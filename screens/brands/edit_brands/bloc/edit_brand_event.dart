import 'package:equatable/equatable.dart';
// import 'package:image_picker/image_picker.dart';

abstract class EditBrandEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBrandData extends EditBrandEvent {
  final String name;
  final String? imageBase64;

  LoadBrandData({required this.name, required this.imageBase64});
}

class UpdateBrandName extends EditBrandEvent {
  final String name;

  UpdateBrandName(this.name);

  @override
  List<Object?> get props => [name];
}

class PickImage extends EditBrandEvent {}

class UpdateBrand extends EditBrandEvent {}

class DeleteBrand extends EditBrandEvent {}
