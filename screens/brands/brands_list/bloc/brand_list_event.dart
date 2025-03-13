import 'package:equatable/equatable.dart';

abstract class BrandListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBrands extends BrandListEvent {}
