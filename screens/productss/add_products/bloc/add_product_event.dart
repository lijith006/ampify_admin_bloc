import 'dart:io';

abstract class AddProductEvent {}

class PickProductImagesEvent extends AddProductEvent {}

class AddProductEvents extends AddProductEvent {
  final String itemName;
  final String price;
  final String description;
  final String? selectedCategoryId;
  final String? selectedBrandId;
  final List<File> images;

  AddProductEvents({
    required this.itemName,
    required this.price,
    required this.description,
    this.selectedCategoryId,
    this.selectedBrandId,
    required this.images,
  });
}

class RemoveImageEvent extends AddProductEvent {
  final int index;

  RemoveImageEvent(this.index);
}
