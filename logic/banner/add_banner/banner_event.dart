part of 'banner_bloc.dart';

@immutable
abstract class BannerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickImagesEvent extends BannerEvent {}

class RemoveImageEvent extends BannerEvent {
  final int index;

  RemoveImageEvent(this.index);

  @override
  List<Object?> get props => [];
}

class UploadBannerEvent extends BannerEvent {
  final String bannerName;

  UploadBannerEvent(this.bannerName);

  @override
  List<Object?> get props => [];
}
