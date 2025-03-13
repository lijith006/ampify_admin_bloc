part of 'add_category_bloc.dart';

abstract class AddCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickImageEvent extends AddCategoryEvent {}

class RemoveImageEvent extends AddCategoryEvent {}

class AddCategorySubmitted extends AddCategoryEvent {
  final String categoryName;
  final File image;

  AddCategorySubmitted({required this.categoryName, required this.image});

  @override
  List<Object?> get props => [categoryName, image];
}
