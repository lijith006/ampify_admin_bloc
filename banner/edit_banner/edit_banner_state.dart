import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class EditBannerState extends Equatable {
  const EditBannerState();

  @override
  List<Object?> get props => [];
}

class EditBannerInitial extends EditBannerState {}

class EditBannerLoading extends EditBannerState {}

class EditBannersLoaded extends EditBannerState {
  final List<Map<String, dynamic>> banners;

  const EditBannersLoaded(this.banners);

  @override
  List<Object?> get props => [banners];
}

class EditBannerUpdated extends EditBannerState {}

class EditBannerImageUpdated extends EditBannerState {
  final String message;

  const EditBannerImageUpdated(this.message);

  @override
  List<Object?> get props => [message];
}

class EditBannerError extends EditBannerState {
  final String message;

  const EditBannerError(this.message);

  @override
  List<Object?> get props => [message];
}

class BannerImagesPicked extends EditBannerState {
  final List<File> selectedImages;

  const BannerImagesPicked(this.selectedImages);

  @override
  List<Object?> get props => [selectedImages];
}

class EditBannerImagesUpdated extends EditBannerState {
  final List<String> existingImages;
  final List<File> selectedImages;

  const EditBannerImagesUpdated(this.existingImages, this.selectedImages);

  @override
  List<Object?> get props => [existingImages, selectedImages];
}
