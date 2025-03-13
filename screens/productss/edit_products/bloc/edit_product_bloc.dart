import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();

  EditProductBloc(QueryDocumentSnapshot product) : super(EditProductInitial()) {
    on<LoadProduct>(_onLoadProduct);
    on<PickImage>(_onPickImage);
    on<RemoveImage>(_onRemoveImage);
    on<UpdateProduct>(_onUpdateProduct);
  }

  // Add methods to fetch categories and brands
  Stream<QuerySnapshot> fetchCategories() {
    return _firestore.collection('categories').snapshots();
  }

  Stream<QuerySnapshot> fetchBrands() {
    return _firestore.collection('brands').snapshots();
  }

  void _onLoadProduct(LoadProduct event, Emitter<EditProductState> emit) async {
    emit(EditProductLoading());
    try {
      final product = event.product;
      final List<Uint8List> selectedImages = [];

      if (product['images'] != null) {
        final images = List<String>.from(product['images']);
        for (var image in images) {
          try {
            Uint8List bytes = base64Decode(image);
            selectedImages.add(bytes);
          } catch (e) {
            print('Failed to decode image:$e');
          }
        }
      }

      emit(EditProductLoaded(
        itemName: product['name'],
        price: product['price'].toString(),
        description: product['description'],
        selectedCategoryId: product['categoryId'],
        selectedBrandId: product['brandId'],
        selectedImages: selectedImages,
      ));
    } catch (e) {
      emit(EditProductError('Failed to load product: $e'));
    }
  }

  void _onPickImage(PickImage event, Emitter<EditProductState> emit) async {
    final state = this.state;
    if (state is EditProductLoaded) {
      if (state.selectedImages.length >= 4) {
        emit(EditProductError('You can only add up to 4 images.'));
        return;
      }
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);
        final Uint8List imageBytes = await imageFile.readAsBytes();
        emit(state
            .copyWith(selectedImages: [...state.selectedImages, imageBytes]));
      }
    }
  }

  void _onRemoveImage(RemoveImage event, Emitter<EditProductState> emit) {
    final state = this.state;
    if (state is EditProductLoaded) {
      final updatedImages = List<Uint8List>.from(state.selectedImages)
        ..removeAt(event.index);
      emit(state.copyWith(selectedImages: updatedImages));
    }
  }

  void _onUpdateProduct(
      UpdateProduct event, Emitter<EditProductState> emit) async {
    final state = this.state;
    if (state is EditProductLoaded) {
      try {
        List<String> imagesBase64 =
            state.selectedImages.map((image) => base64Encode(image)).toList();

        await _firestore.collection('products').doc(event.productId).update({
          'name': event.itemName,
          'price': double.parse(event.price),
          'description': event.description,
          'categoryId': event.selectedCategoryId,
          'brandId': event.selectedBrandId,
          'images': imagesBase64,
        });

        emit(EditProductSuccess('Product updated successfully!'));
      } catch (e) {
        emit(EditProductError('Failed to update product: $e'));
      }
    }
  }
}
