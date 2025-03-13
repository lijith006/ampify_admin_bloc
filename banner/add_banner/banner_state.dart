part of 'banner_bloc.dart';

@immutable
abstract class BannerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerImagesPicked extends BannerState {
  final List<File> selectedImages;

  BannerImagesPicked(this.selectedImages);

  @override
  List<Object?> get props => [selectedImages];
}

class BannerUploaded extends BannerState {}

class BannerError extends BannerState {
  final String message;
  BannerError(this.message);

  @override
  List<Object?> get props => [message];
}
