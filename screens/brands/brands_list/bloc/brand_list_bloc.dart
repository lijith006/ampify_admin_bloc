import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'brand_list_event.dart';
import 'brand_list_state.dart';
import 'package:ampify_admin_bloc/models/brand_model.dart';

class BrandListBloc extends Bloc<BrandListEvent, BrandListState> {
  BrandListBloc() : super(BrandListLoadingState()) {
    on<LoadBrands>(_onLoadBrands);
  }

  Future<void> _onLoadBrands(
      LoadBrands event, Emitter<BrandListState> emit) async {
    try {
      emit(BrandListLoadingState());

      final snapshot =
          await FirebaseFirestore.instance.collection('brands').get();

      final brands = snapshot.docs.map((doc) {
        return BrandModel.fromMap(doc.data());
      }).toList();

      emit(BrandListLoadedState(brands: brands));
    } catch (e) {
      emit(BrandListErrorState(errorMessage: "Failed to load brands: $e"));
    }
  }
}
