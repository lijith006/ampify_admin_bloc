part of 'product_details_bloc.dart';

abstract class ProductDetailEvent {}

class FetchProductDetails extends ProductDetailEvent {
  final String productId;

  FetchProductDetails(this.productId);
}
