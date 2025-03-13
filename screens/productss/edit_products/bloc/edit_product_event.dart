part of 'edit_product_bloc.dart';

abstract class EditProductEvent {}

class LoadProduct extends EditProductEvent {
  final QueryDocumentSnapshot product;

  LoadProduct(this.product);
}

class PickImage extends EditProductEvent {}

class RemoveImage extends EditProductEvent {
  final int index;

  RemoveImage(this.index);
}

class UpdateProduct extends EditProductEvent {
  final String productId;
  final String itemName;
  final String price;
  final String description;
  final String? selectedCategoryId;
  final String? selectedBrandId;

  UpdateProduct({
    required this.productId,
    required this.itemName,
    required this.price,
    required this.description,
    this.selectedCategoryId,
    this.selectedBrandId,
  });
}
