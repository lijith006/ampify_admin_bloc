import 'package:equatable/equatable.dart';
import 'package:ampify_admin_bloc/models/brand_model.dart';

abstract class BrandListState extends Equatable {
  @override
  List<Object> get props => [];
}

class BrandListLoadingState extends BrandListState {} //  loading brands

class BrandListLoadedState extends BrandListState {
  final List<BrandModel> brands;

  BrandListLoadedState({required this.brands});

  @override
  List<Object> get props => [brands];
}

class BrandListErrorState extends BrandListState {
  final String errorMessage;

  BrandListErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
