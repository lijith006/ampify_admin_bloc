// part of 'add_product_bloc.dart';

// abstract class AddProductState {}

// class AddProductInitial extends AddProductState {}

// class ImagesPickedState extends AddProductState {
//   final List<File> images;

//   ImagesPickedState(this.images);
// }

// class AddProductSuccessState extends AddProductState {
//   final String message;

//   AddProductSuccessState(this.message);
// }

// class AddProductErrorState extends AddProductState {
//   final String error;

//   AddProductErrorState(this.error);
// }
//------------------------------------------------------------------------------------
part of 'add_product_bloc.dart';

abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

// class ImagesPickedState extends AddProductState {
//   final List<File> images;

//   ImagesPickedState(this.images);
// }

class ImagesPickedState extends AddProductState {
  final List<Uint8List> images;

  ImagesPickedState(this.images);
}

class AddProductSuccessState extends AddProductState {
  final String message;

  AddProductSuccessState(this.message);
}

class AddProductErrorState extends AddProductState {
  final String error;

  AddProductErrorState(this.error);
}
