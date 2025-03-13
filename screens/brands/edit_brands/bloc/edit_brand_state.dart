import 'package:equatable/equatable.dart';

abstract class EditBrandState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditBrandInitial extends EditBrandState {}

class EditBrandLoading extends EditBrandState {}

class EditBrandLoaded extends EditBrandState {
  final String name;
  final String? imageBase64;

  EditBrandLoaded({required this.name, required this.imageBase64});

  @override
  List<Object?> get props => [name, imageBase64];
}

class EditBrandSuccess extends EditBrandState {
  final String message;

  EditBrandSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EditBrandFailure extends EditBrandState {
  final String error;

  EditBrandFailure(this.error);

  @override
  List<Object?> get props => [error];
}
