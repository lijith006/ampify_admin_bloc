part of 'add_category_bloc.dart';

abstract class AddCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddCategoryInitial extends AddCategoryState {}

class AddCategoryImagePicked extends AddCategoryState {
  final File image;
  AddCategoryImagePicked(this.image);

  @override
  List<Object?> get props => [image];
}

class AddCategoryImageRemoved extends AddCategoryState {}

class AddCategoryLoading extends AddCategoryState {}

class AddCategorySuccess extends AddCategoryState {}

class AddCategoryFailure extends AddCategoryState {
  final String error;
  AddCategoryFailure(this.error);

  @override
  List<Object?> get props => [error];
}
