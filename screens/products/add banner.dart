import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class AddBanner extends StatefulWidget {
  const AddBanner({super.key});

  @override
  State<AddBanner> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBanner> {
  final TextEditingController bannerController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<File> selectedImages = [];
  // String? base64Image;
  // final List<XFile?> _pickedImages = [];
  final ImagePicker _imagePicker = ImagePicker();

  // Pick Image from Gallery
  void pickImage() async {
    final List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  String convertToBase64(File imageFile) {
    // Decode the image to work with it
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image != null) {
      // Resize the image (optional)
      img.Image resizedImage = img.copyResize(image,
          width: 600); // Resize to 600px width (adjust as needed)
      // Convert to bytes and encode in Base64
      List<int> compressedBytes =
          img.encodeJpg(resizedImage, quality: 85); // Compress with 85% quality
      return base64Encode(compressedBytes);
    } else {
      throw Exception('Failed to decode image');
    }
  }

  // Convert Multiple Images to Base64
  Future<List<String>> convertImagesToBase64() async {
    List<String> base64Images = [];
    for (var image in selectedImages) {
      base64Images.add(convertToBase64(image)); // Convert each image to Base64
    }
    return base64Images;
  }

//upload
  Future<void> uploadBanner() async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No image selected')));
      return;
    }
    String bannerName = bannerController.text.trim();
    if (bannerName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a banner name')));
      return;
    }
//convert
    List<String> base64Images = await convertImagesToBase64();
    //upload to firebase
    await firestore.collection('banners').add({
      'images': base64Images,
      'bannerName': bannerName,
      'timestamp': FieldValue.serverTimestamp()
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Banner uploaded!')));

    setState(() {
      selectedImages.clear();
      bannerController.clear();
    });
  }

  //Remove image
  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Upload Banner'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: selectedImages.length < 5
                          ? selectedImages.length + 1
                          : selectedImages
                              .length, // will show add button if images less than 4
                      itemBuilder: (context, index) {
                        if (index == selectedImages.length &&
                            selectedImages.length < 5) {
                          // Add Photo Button
                          return GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0XFFe1d5c9),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 138, 136, 136)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.add_a_photo_outlined),
                            ),
                          );
                        }

                        // Display Selected Images
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(selectedImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => removeImage(index),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                  // Container(
                  //   height: 200,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: selectedImages.isEmpty
                  //       ? GestureDetector(
                  //           onTap: pickImage,
                  //           child: const Center(
                  //             child: Icon(
                  //               Icons.add_a_photo_outlined,
                  //               size: 50,
                  //             ),
                  //           ),
                  //         )
                  //       : Stack(
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(8),
                  //               child: Image.file(
                  //                 File(selectedImages.path),
                  //                 fit: BoxFit.cover,
                  //                 height: 200,
                  //                 width: double.infinity,
                  //               ),
                  //             ),
                  //             Positioned(
                  //                 top: 4,
                  //                 right: 4,
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     setState(() {
                  //                       selectedImage = null;
                  //                     });
                  //                   },
                  //                   child: Container(
                  //                     decoration: const BoxDecoration(
                  //                       color: Colors.red,
                  //                       shape: BoxShape.circle,
                  //                     ),
                  //                     child: const Icon(
                  //                       Icons.close,
                  //                       color: Colors.white,
                  //                       size: 20,
                  //                     ),
                  //                   ),
                  //                 ))
                  //           ],
                  //         ),
                  // ),
                  ,
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                      controller: bannerController, labelText: 'Brand name'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      label: 'Add banner',
                      onTap: () {
                        uploadBanner();
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
