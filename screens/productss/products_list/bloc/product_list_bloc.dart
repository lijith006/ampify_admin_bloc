import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProductListBloc() : super(ProductListInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<DeleteProduct>(_onDeleteProduct);
  }

  void _onFetchProducts(
      FetchProducts event, Emitter<ProductListState> emit) async {
    emit(ProductListLoading());
    try {
      final snapshot = await _firestore.collection('products').get();
      final products = snapshot.docs;
      emit(ProductListLoaded(products));
    } catch (e) {
      emit(ProductListError('Failed to fetch products: $e'));
    }
  }

  void _onDeleteProduct(
      DeleteProduct event, Emitter<ProductListState> emit) async {
    final state = this.state;
    if (state is ProductListLoaded) {
      try {
        await _firestore.collection('products').doc(event.productId).delete();
        emit(ProductListLoaded(
            state.products..removeWhere((doc) => doc.id == event.productId)));
      } catch (e) {
        emit(ProductListError('Failed to delete product: $e'));
      }
    }
  }
}
