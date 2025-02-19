// import 'dart:convert';
// import 'dart:io';
// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image/image.dart' as img;
// import 'edit_banner_event.dart';
// import 'edit_banner_state.dart';

// class EditBannerBloc extends Bloc<EditBannerEvent, EditBannerState> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   List<File> selectedImages = [];
//   List<String> existingImages = [];
//   EditBannerBloc() : super(EditBannerInitial()) {
//     on<LoadEditBannersEvent>((event, emit) async {
//       emit(EditBannerLoading());
//       try {
//         QuerySnapshot snapshot = await firestore
//             .collection('banners')
//             .orderBy('timestamp', descending: true)
//             .get();
//         List<Map<String, dynamic>> banners = snapshot.docs.map((doc) {
//           return {
//             'id': doc.id,
//             'bannerName': doc['bannerName'],
//             'images': List<String>.from(doc['images']),
//           };
//         }).toList();
//         emit(EditBannersLoaded(banners));
//       } catch (e) {
//         emit(EditBannerError('Failed to load banners'));
//       }
//     });

//     on<DeleteEditBannerEvent>((event, emit) async {
//       try {
//         await firestore.collection('banners').doc(event.bannerId).delete();
//         add(LoadEditBannersEvent()); // Reload
//       } catch (e) {
//         emit(EditBannerError('Failed to delete banner'));
//       }
//     });

//     on<UpdateEditBannerEvent>((event, emit) async {
//       if (event.bannerName.isEmpty) {
//         emit(EditBannerError('Please enter a banner name'));
//         return;
//       }

//       emit(EditBannerLoading());
//       try {
//         DocumentSnapshot bannerDoc =
//             await firestore.collection('banners').doc(event.bannerId).get();

//         List<String> existingImages =
//             List<String>.from(bannerDoc['images'] ?? []);

//         List<String> base64Images = await convertImagesToBase64(event.images);

//         List<String> updatedImages = [...existingImages, ...base64Images];

//         await firestore.collection('banners').doc(event.bannerId).update({
//           'bannerName': event.bannerName,
//           'images': updatedImages,
//         });
//         selectedImages.clear(); //
//         emit(EditBannerImageUpdated('Banner image updated successfully!'));
//         // emit(EditBannerUpdated());
//         add(LoadEditBannersEvent()); // Reload after updating--
//       } catch (e) {
//         emit(EditBannerError('Failed to update banner'));
//       }
//     });
//     on<AddImageEvent>((event, emit) {
//       selectedImages.add(event.image);
//       emit(BannerImagesPicked(List.from(selectedImages)));
//     });

//     on<RemoveImageEvent>((event, emit) {
//       if (event.index >= 0 && event.index < selectedImages.length) {
//         selectedImages.removeAt(event.index);
//         emit(BannerImagesPicked(List.from(selectedImages)));
//       }
//     });
// //--------------------------------------------------------------------
//     on<UpdateExistingImagesEvent>((event, emit) {
//       existingImages = event.existingImages;
//       emit(EditBannerImagesUpdated(existingImages, selectedImages));
//     });

//     on<UpdateSelectedImagesEvent>((event, emit) {
//       selectedImages = event.selectedImages;
//       emit(EditBannerImagesUpdated(existingImages, selectedImages));
//     });
//   }

// //--------------------------------------------------------------------
//   Future<List<String>> convertImagesToBase64(List<File> images) async {
//     List<String> base64Images = [];
//     for (var image in images) {
//       base64Images.add(convertToBase64(image));
//     }
//     return base64Images;
//   }

//   String convertToBase64(File imageFile) {
//     img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
//     if (image != null) {
//       img.Image resizedImage = img.copyResize(image, width: 600);
//       List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 85);
//       return base64Encode(compressedBytes);
//     } else {
//       throw Exception('Failed to decode image');
//     }
//   }
// }
//********************************************************* */

import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as img;
import 'edit_banner_event.dart';
import 'edit_banner_state.dart';

class EditBannerBloc extends Bloc<EditBannerEvent, EditBannerState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<File> selectedImages = [];
  List<String> existingImages = [];

  EditBannerBloc() : super(EditBannerInitial()) {
    on<LoadEditBannersEvent>((event, emit) async {
      emit(EditBannerLoading());
      try {
        QuerySnapshot snapshot = await firestore
            .collection('banners')
            .orderBy('timestamp', descending: true)
            .get();
        List<Map<String, dynamic>> banners = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'bannerName': doc['bannerName'],
            'images': List<String>.from(doc['images']),
          };
        }).toList();
        emit(EditBannersLoaded(banners));
      } catch (e) {
        emit(const EditBannerError('Failed to load banners'));
      }
    });

    on<DeleteEditBannerEvent>((event, emit) async {
      try {
        await firestore.collection('banners').doc(event.bannerId).delete();
        add(LoadEditBannersEvent());
      } catch (e) {
        emit(const EditBannerError('Failed to delete banner'));
      }
    });

    on<UpdateEditBannerEvent>((event, emit) async {
      if (event.bannerName.isEmpty) {
        emit(const EditBannerError('Please enter a banner name'));
        return;
      }

      emit(EditBannerLoading());
      try {
        print('Updating banner with ID: ${event.bannerId}');
        print('Existing Images: ${event.existingImages}');
        print('Selected Images: ${event.images}');
        List<String> base64Images = await convertImagesToBase64(event.images);

        await firestore.collection('banners').doc(event.bannerId).update({
          'bannerName': event.bannerName,
          'images': [...event.existingImages, ...base64Images],
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Fetch the updated banners list
        QuerySnapshot snapshot = await firestore
            .collection('banners')
            .orderBy('timestamp', descending: true)
            .get();
        List<Map<String, dynamic>> banners = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'bannerName': doc['bannerName'],
            'images': List<String>.from(doc['images']),
          };
        }).toList();

        // selectedImages.clear();
        emit(EditBannersLoaded(banners));
        emit(const EditBannerImageUpdated('Banner updated successfully!'));
        // add(LoadEditBannersEvent());
      } catch (e) {
        print('Failed to update banner: $e');
        emit(EditBannerError('Failed to update banner:$e'));
      }
    });

    on<AddImageEvent>((event, emit) {
      selectedImages.add(event.image);
      emit(BannerImagesPicked(List.from(selectedImages)));
    });

    on<RemoveImageEvent>((event, emit) {
      if (event.index >= 0 && event.index < selectedImages.length) {
        selectedImages.removeAt(event.index);
        emit(BannerImagesPicked(List.from(selectedImages)));
      }
    });

    on<UpdateExistingImagesEvent>((event, emit) {
      existingImages = event.existingImages;
      emit(EditBannerImagesUpdated(existingImages, selectedImages));
    });

    on<UpdateSelectedImagesEvent>((event, emit) {
      selectedImages = event.selectedImages;
      emit(EditBannerImagesUpdated(existingImages, selectedImages));
    });
  }

  Future<List<String>> convertImagesToBase64(List<File> images) async {
    List<String> base64Images = [];
    for (var image in images) {
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
