// import 'dart:io';

// import 'package:equatable/equatable.dart';

// abstract class EditBannerEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class LoadEditBannersEvent extends EditBannerEvent {}

// class DeleteEditBannerEvent extends EditBannerEvent {
//   final String bannerId;
//   DeleteEditBannerEvent(this.bannerId);

//   @override
//   List<Object?> get props => [bannerId];
// }

// class UpdateEditBannerEvent extends EditBannerEvent {
//   final String bannerId;
//   final String bannerName;
//   final List<File> images;

//   UpdateEditBannerEvent(
//       {required this.bannerId,
//       required this.bannerName,
//       required this.images,
//       required List<String> existingImages});

//   @override
//   List<Object?> get props => [bannerId, bannerName, images];
// }

// class AddImageEvent extends EditBannerEvent {
//   final File image;

//   AddImageEvent(this.image);

//   @override
//   List<Object?> get props => [image];
// }

// class RemoveImageEvent extends EditBannerEvent {
//   final int index;

//   RemoveImageEvent(this.index);

//   @override
//   List<Object?> get props => [index];
// }

// class UpdateExistingImagesEvent extends EditBannerEvent {
//   final List<String> existingImages;
//   UpdateExistingImagesEvent(this.existingImages);
// }

// class UpdateSelectedImagesEvent extends EditBannerEvent {
//   final List<File> selectedImages;
//   UpdateSelectedImagesEvent(this.selectedImages);
// }
//*************************************************** */

import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class EditBannerEvent extends Equatable {
  const EditBannerEvent();

  @override
  List<Object?> get props => [];
}

class LoadEditBannersEvent extends EditBannerEvent {}

class DeleteEditBannerEvent extends EditBannerEvent {
  final String bannerId;

  const DeleteEditBannerEvent(this.bannerId);

  @override
  List<Object?> get props => [bannerId];
}

class UpdateEditBannerEvent extends EditBannerEvent {
  final String bannerId;
  final String bannerName;
  final List<File> images;
  final List<String> existingImages;

  const UpdateEditBannerEvent({
    required this.bannerId,
    required this.bannerName,
    required this.images,
    required this.existingImages,
  });

  @override
  List<Object?> get props => [bannerId, bannerName, images, existingImages];
}

class AddImageEvent extends EditBannerEvent {
  final File image;

  const AddImageEvent(this.image);

  @override
  List<Object?> get props => [image];
}

class RemoveImageEvent extends EditBannerEvent {
  final int index;

  const RemoveImageEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateExistingImagesEvent extends EditBannerEvent {
  final List<String> existingImages;

  const UpdateExistingImagesEvent(this.existingImages);

  @override
  List<Object?> get props => [existingImages];
}

class UpdateSelectedImagesEvent extends EditBannerEvent {
  final List<File> selectedImages;

  const UpdateSelectedImagesEvent(this.selectedImages);

  @override
  List<Object?> get props => [selectedImages];
}
