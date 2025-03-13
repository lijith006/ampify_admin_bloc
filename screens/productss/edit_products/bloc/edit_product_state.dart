part of 'edit_product_bloc.dart';

abstract class EditProductState {}

class EditProductInitial extends EditProductState {}

class EditProductLoading extends EditProductState {}

class EditProductLoaded extends EditProductState {
  final String itemName;
  final String price;
  final String description;
  final String? selectedCategoryId;
  final String? selectedBrandId;
  final List<Uint8List> selectedImages;

  EditProductLoaded({
    required this.itemName,
    required this.price,
    required this.description,
    this.selectedCategoryId,
    this.selectedBrandId,
    required this.selectedImages,
  });

  EditProductLoaded copyWith({
    String? itemName,
    String? price,
    String? description,
    String? selectedCategoryId,
    String? selectedBrandId,
    List<Uint8List>? selectedImages,
  }) {
    return EditProductLoaded(
      itemName: itemName ?? this.itemName,
      price: price ?? this.price,
      description: description ?? this.description,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedBrandId: selectedBrandId ?? this.selectedBrandId,
      selectedImages: selectedImages ?? this.selectedImages,
    );
  }
}

class EditProductSuccess extends EditProductState {
  final String message;

  EditProductSuccess(this.message);
}

class EditProductError extends EditProductState {
  final String message;

  EditProductError(this.message);
}
