import 'package:equatable/equatable.dart';

abstract class EditCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditCategoryInitial extends EditCategoryState {}

class EditCategoryLoaded extends EditCategoryState {
  final String name;
  final String? imageBase64;

  EditCategoryLoaded({required this.name, this.imageBase64});

  @override
  List<Object?> get props => [name, imageBase64];
}

class EditCategoryLoading extends EditCategoryState {}

class EditCategoryUpdated extends EditCategoryState {}

class EditCategoryDeleted extends EditCategoryState {}

class EditCategoryError extends EditCategoryState {
  final String message;

  EditCategoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
