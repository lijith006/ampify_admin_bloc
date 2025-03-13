import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_category_event.dart';
import 'edit_category_state.dart';

class EditCategoryBloc extends Bloc<EditCategoryEvent, EditCategoryState> {
  EditCategoryBloc() : super(EditCategoryInitial()) {
    on<LoadCategoryEvent>((event, emit) {
      emit(
          EditCategoryLoaded(name: event.name, imageBase64: event.imageBase64));
    });

    on<PickImageEvent>((event, emit) {
      if (state is EditCategoryLoaded) {
        final currentState = state as EditCategoryLoaded;
        emit(EditCategoryLoaded(
            name: currentState.name, imageBase64: event.imageBase64));
      }
    });

    on<UpdateCategoryEvent>((event, emit) async {
      emit(EditCategoryLoading());
      try {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(event.id)
            .update({
          'name': event.name,
          'image': event.imageBase64,
        });
        emit(EditCategoryUpdated());
      } catch (e) {
        emit(EditCategoryError(message: 'Error updating category: $e'));
      }
    });

    on<DeleteCategoryEvent>((event, emit) async {
      emit(EditCategoryLoading());
      try {
        final productsSnapshot = await FirebaseFirestore.instance
            .collection('products')
            .where('categoryId', isEqualTo: event.id)
            .get();

        if (productsSnapshot.docs.isNotEmpty) {
          emit(EditCategoryError(
              message: 'Cannot delete: Products exist in this category.'));
          return;
        }

        await FirebaseFirestore.instance
            .collection('categories')
            .doc(event.id)
            .delete();
        emit(EditCategoryDeleted());
      } catch (e) {
        emit(EditCategoryError(message: 'Error deleting category: $e'));
      }
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      add(PickImageEvent(imageBase64: base64Encode(bytes)));
    }
  }
}
