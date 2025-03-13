import 'dart:convert';
import 'dart:io';

import 'package:ampify_admin_bloc/models/category_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';

part 'add_category_event.dart';
part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final ImagePicker _picker = ImagePicker();

  AddCategoryBloc() : super(AddCategoryInitial()) {
    on<PickImageEvent>((event, emit) async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(AddCategoryImagePicked(File(image.path)));
      }
    });

    on<RemoveImageEvent>((event, emit) {
      emit(AddCategoryImageRemoved());
    });

    on<AddCategorySubmitted>((event, emit) async {
      emit(AddCategoryLoading());

      try {
        // Check if the category exists
        final categoryExists = await doesCategoryExist(event.categoryName);
        if (categoryExists) {
          emit(AddCategoryFailure("Category already exists!"));
          return;
        }

        // Encode image to Base64
        final base64Image = await _encodeImageToBase64(event.image);

        // Create category with a generated ID
        String categoryId =
            FirebaseFirestore.instance.collection('categories').doc().id;

        Category category = Category(
          id: categoryId,
          name: event.categoryName.trim(),
          image: base64Image,
        );

        // Add category to Firestore
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .set(category.toMap());

        emit(AddCategorySuccess());
      } catch (e) {
        emit(AddCategoryFailure("Error adding category: $e"));
      }
    });
  }

  Future<bool> doesCategoryExist(String categoryName) async {
    final existingCategory = await FirebaseFirestore.instance
        .collection('categories')
        .where('name', isEqualTo: categoryName.trim())
        .get();
    return existingCategory.docs.isNotEmpty;
  }

  Future<String> _encodeImageToBase64(File image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }
}
