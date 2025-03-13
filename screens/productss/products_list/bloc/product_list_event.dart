part of 'product_list_bloc.dart';

abstract class ProductListEvent {}

class FetchProducts extends ProductListEvent {}

class DeleteProduct extends ProductListEvent {
  final String productId;

  DeleteProduct(this.productId);
}
