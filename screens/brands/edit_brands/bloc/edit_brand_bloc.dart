import 'dart:convert';
import 'package:ampify_admin_bloc/models/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_brand_event.dart';
import 'edit_brand_state.dart';

class EditBrandBloc extends Bloc<EditBrandEvent, EditBrandState> {
  final BrandModel brand;

  EditBrandBloc(this.brand) : super(EditBrandInitial()) {
    on<LoadBrandData>((event, emit) {
      emit(EditBrandLoaded(name: event.name, imageBase64: event.imageBase64));
    });

    on<UpdateBrandName>((event, emit) {
      if (state is EditBrandLoaded) {
        final currentState = state as EditBrandLoaded;
        emit(EditBrandLoaded(
            name: event.name, imageBase64: currentState.imageBase64));
      }
    });

    on<PickImage>((event, emit) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final base64Image = base64Encode(bytes);
        if (state is EditBrandLoaded) {
          final currentState = state as EditBrandLoaded;
          emit(EditBrandLoaded(
              name: currentState.name, imageBase64: base64Image));
        }
      }
    });

    on<UpdateBrand>((event, emit) async {
      if (state is EditBrandLoaded) {
        final currentState = state as EditBrandLoaded;
        if (currentState.name.isEmpty) {
          emit(EditBrandFailure('Please enter the brand name.'));
          return;
        }

        try {
          await FirebaseFirestore.instance
              .collection('brands')
              .doc(brand.id)
              .update({
            'name': currentState.name,
            'image': currentState.imageBase64,
          });
          emit(EditBrandSuccess('Brand updated successfully!'));
        } catch (e) {
          emit(EditBrandFailure('Error updating brand: $e'));
        }
      }
    });

    on<DeleteBrand>((event, emit) async {
      try {
        final productsSnapshot = await FirebaseFirestore.instance
            .collection('products')
            .where('brandId', isEqualTo: brand.id)
            .get();

        if (productsSnapshot.docs.isNotEmpty) {
          emit(EditBrandFailure(
              'Cannot delete brand: Products still exist under this brand.'));
          return;
        }

        await FirebaseFirestore.instance
            .collection('brands')
            .doc(brand.id)
            .delete();
        emit(EditBrandSuccess('Brand deleted successfully!'));
      } catch (e) {
        emit(EditBrandFailure('Error deleting brand: $e'));
      }
    });
  }
}
