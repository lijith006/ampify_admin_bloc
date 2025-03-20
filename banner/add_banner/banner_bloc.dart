import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:image/image.dart' as img;

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  List<File> selectedImages = [];
  BannerBloc() : super(BannerInitial()) {
    //p i c k    I m a g e
    on<PickImagesEvent>((event, emit) async {
      if (selectedImages.length >= 5) {
        emit(BannerError('You can select up to 5 images only'));
        return;
      }
      final List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();
      if (pickedFiles != null) {
        int availableSlots = 5 - selectedImages.length;
        selectedImages.addAll(
            pickedFiles.take(availableSlots).map((file) => File(file.path)));

        emit(BannerImagesPicked(List.from(selectedImages)));
      }
    });

    on<RemoveImageEvent>((event, emit) {
      if (event.index >= 0 && event.index < selectedImages.length) {
        selectedImages.removeAt(event.index);
        emit(BannerImagesPicked(List.from(selectedImages)));
      }
    });
    on<UploadBannerEvent>((event, emit) async {
      if (selectedImages.isEmpty) {
        emit(BannerError('No image selected'));
        return;
      }

      if (event.bannerName.isEmpty) {
        emit(BannerError('Please enter a banner name'));
        return;
      }

      emit(BannerLoading());

      // Check if banner name already exists
      try {
        emit(BannerLoading());

        // check - firestore if the bannerName already exists
        var querySnapshot = await firestore
            .collection('banners')
            .where('bannerName', isEqualTo: event.bannerName)
            .get();

        // If a document exists with the same banner name,--- show an error
        if (querySnapshot.docs.isNotEmpty) {
          emit(BannerError(
              'Banner name already exists. Please choose another name.'));
          return;
        }
        // If banner name does not exist, proceed with image upload
        List<String> base64Images = await convertImagesToBase64();
        await firestore.collection('banners').add({
          'images': base64Images,
          'bannerName': event.bannerName,
          'timestamp': FieldValue.serverTimestamp()
        });

        selectedImages.clear();
        emit(BannerUploaded());
        //UI --reset
        emit(BannerImagesPicked(List.from(selectedImages)));
      } catch (e) {
        emit(BannerError('Failed to upload banner'));
      }
    });
  }
  Future<List<String>> convertImagesToBase64() async {
    List<String> base64Images = [];
    for (var image in selectedImages) {
      base64Images.add(convertToBase64(image));
    }
    return base64Images;
  }

  String convertToBase64(File imageFile) {
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image != null) {
      img.Image resizedImage = img.copyResize(image, width: 600);
      List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 85);
      return base64Encode(compressedBytes);
    } else {
      throw Exception('Failed to decode image');
    }
  }
}
