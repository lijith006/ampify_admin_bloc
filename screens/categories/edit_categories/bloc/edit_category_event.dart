import 'package:equatable/equatable.dart';

abstract class EditCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCategoryEvent extends EditCategoryEvent {
  final String name;
  final String? imageBase64;

  LoadCategoryEvent({required this.name, this.imageBase64});
}

class PickImageEvent extends EditCategoryEvent {
  final String imageBase64;

  PickImageEvent({required this.imageBase64});
}

class UpdateCategoryEvent extends EditCategoryEvent {
  final String id;
  final String name;
  final String? imageBase64;

  UpdateCategoryEvent({required this.id, required this.name, this.imageBase64});
}

class DeleteCategoryEvent extends EditCategoryEvent {
  final String id;

  DeleteCategoryEvent({required this.id});
}
