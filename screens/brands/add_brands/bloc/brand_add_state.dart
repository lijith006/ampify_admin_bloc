import 'package:image_picker/image_picker.dart';

abstract class BrandAddState {}

class BrandAddInitial extends BrandAddState {}

class BrandAddLoading extends BrandAddState {}

class BrandAddSuccess extends BrandAddState {}

class BrandAddError extends BrandAddState {
  final String message;
  BrandAddError(this.message);
}

class BrandImageRemoved extends BrandAddState {}

class BrandImageSelected extends BrandAddState {
  final XFile image;
  BrandImageSelected(this.image);
}
