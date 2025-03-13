part of 'product_details_bloc.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final List<String> images;
  final String name;
  final String description;
  final double price;

  ProductDetailLoaded({
    required this.images,
    required this.name,
    required this.description,
    required this.price,
  });
}

class ProductDetailError extends ProductDetailState {
  final String message;

  ProductDetailError(this.message);
}
