import 'dart:convert';
import 'dart:io';

import 'package:ampify_admin_bloc/models/products_model.dart';
import 'package:ampify_admin_bloc/screens/productss/add_products/bloc/add_product_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();

  AddProductBloc() : super(AddProductInitial()) {
    on<PickProductImagesEvent>(_onPickImages);
    on<AddProductEvents>(_onAddProduct);
    on<RemoveImageEvent>(_onRemoveImage);
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<AddProductState> emit) {
    if (state is ImagesPickedState) {
      final currentState = state as ImagesPickedState;
      final updatedImages = List<File>.from(currentState.images);
      updatedImages.removeAt(event.index);

      emit(ImagesPickedState(updatedImages));
    }
  }

  void _onPickImages(
      PickProductImagesEvent event, Emitter<AddProductState> emit) async {
    final List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();
    if (pickedFiles != null) {
      emit(ImagesPickedState(
          pickedFiles.map((file) => File(file.path)).toList()));
    }
  }

  void _onAddProduct(
      AddProductEvents event, Emitter<AddProductState> emit) async {
    if (event.selectedCategoryId == null ||
        event.selectedBrandId == null ||
        event.itemName.isEmpty ||
        event.description.isEmpty ||
        event.price.isEmpty ||
        event.images.isEmpty) {
      emit(AddProductErrorState('Please fill all fields and select images.'));
      return;
    }

    try {
      final String productId = _firestore.collection('products').doc().id;
      final List<String> base64Images = [];
      for (var image in event.images) {
        String base64Image = await _compressAndConvertToBase64(image);
        base64Images.add(base64Image);
      }

      final product = Product(
        id: productId,
        name: event.itemName,
        price: double.parse(event.price),
        description: event.description,
        categoryId: event.selectedCategoryId!,
        brandId: event.selectedBrandId!,
        images: base64Images,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('products')
          .doc(productId)
          .set(product.toMap());

      emit(AddProductSuccessState('Product added successfully!'));
    } catch (e) {
      emit(AddProductErrorState('Error adding product: $e'));
    }
  }

  Future<String> _compressAndConvertToBase64(File image) async {
    final compressedImage = await FlutterImageCompress.compressWithFile(
      image.absolute.path,
      minWidth: 500,
      minHeight: 500,
      quality: 80,
    );

    final base64Image = base64Encode(compressedImage!);
    return base64Image;
  }
}
