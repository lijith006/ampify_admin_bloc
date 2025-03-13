import 'package:equatable/equatable.dart';
import 'package:ampify_admin_bloc/models/category_model.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoryEvent {}

class UpdateCategory extends CategoryEvent {
  final Category category;

  UpdateCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class DeleteCategory extends CategoryEvent {
  final String categoryId;

  DeleteCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
