import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<FetchProductDetails>(_onFetchProductDetails);
  }

  void _onFetchProductDetails(
      FetchProductDetails event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());
    try {
      final snapshot =
          await _firestore.collection('products').doc(event.productId).get();

      if (snapshot.exists) {
        final productData = snapshot.data() as Map<String, dynamic>;
        emit(ProductDetailLoaded(
          images: List<String>.from(productData['images'] ?? []),
          name: productData['name'] ?? "No Name",
          description: productData['description'] ?? "No description available",
          price: (productData['price'] ?? 0.0).toDouble(),
        ));
      } else {
        emit(ProductDetailError('Product not found'));
      }
    } catch (e) {
      emit(ProductDetailError('Failed to fetch product details: $e'));
    }
  }
}
