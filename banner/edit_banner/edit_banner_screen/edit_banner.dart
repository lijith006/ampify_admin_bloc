import 'dart:convert';
import 'dart:io';

import 'package:ampify_admin_bloc/banner/edit_banner/edit_banner_bloc.dart';
import 'package:ampify_admin_bloc/banner/edit_banner/edit_banner_event.dart';
import 'package:ampify_admin_bloc/banner/edit_banner/edit_banner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditBannerScreen extends StatefulWidget {
  const EditBannerScreen({Key? key}) : super(key: key);

  @override
  State<EditBannerScreen> createState() => _EditBannerScreenState();
}

class _EditBannerScreenState extends State<EditBannerScreen> {
  final TextEditingController bannerNameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  List<File> selectedImages = [];
  List<String> existingImages = [];

  @override
  void initState() {
    super.initState();
    context.read<EditBannerBloc>().add(LoadEditBannersEvent());
  }

  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();
    if (pickedFiles != null) {
      int totalImages = existingImages.length + selectedImages.length;
      int remainingSlots = 6 - totalImages;

      if (remainingSlots > 0) {
        setState(() {
          selectedImages.addAll(
            pickedFiles
                .take(remainingSlots)
                .map((file) => File(file.path))
                .toList(),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Maximum 6 images allowed')),
        );
      }
    }
  }

  void showEditDialog(Map<String, dynamic> banner) {
    bannerNameController.text = banner['bannerName'];
    context
        .read<EditBannerBloc>()
        .add(UpdateExistingImagesEvent(List.from(banner['images'])));
    context.read<EditBannerBloc>().add(const UpdateSelectedImagesEvent([]));

    showDialog(
      context: context,
      builder: (context) => BlocBuilder<EditBannerBloc, EditBannerState>(
        builder: (context, state) {
          List<String> existingImages = [];
          List<File> selectedImages = [];

          if (state is EditBannerImagesUpdated) {
            existingImages = state.existingImages;
            selectedImages = state.selectedImages;
          }

          return AlertDialog(
            title: const Text('Edit Banner'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: bannerNameController,
                    decoration: const InputDecoration(labelText: 'Banner Name'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final List<XFile>? pickedFiles =
                          await _imagePicker.pickMultiImage();
                      if (pickedFiles != null) {
                        int totalImages =
                            existingImages.length + selectedImages.length;
                        int remainingSlots = 6 - totalImages;

                        if (remainingSlots > 0) {
                          List<File> newImages = pickedFiles
                              .take(remainingSlots)
                              .map((file) => File(file.path))
                              .toList();

                          context.read<EditBannerBloc>().add(
                                UpdateSelectedImagesEvent(
                                    [...selectedImages, ...newImages]),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Maximum 6 images allowed')),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.add_photo_alternate),
                    label: const Text('Add Images'),
                  ),
                  const SizedBox(height: 16),
                  if (existingImages.isNotEmpty) ...[
                    const Text('Existing Images:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        existingImages.length,
                        (index) => Stack(
                          children: [
                            Image.memory(
                              base64Decode(existingImages[index]),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () {
                                  context.read<EditBannerBloc>().add(
                                        UpdateExistingImagesEvent(
                                          List.from(existingImages)
                                            ..removeAt(index),
                                        ),
                                      );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (selectedImages.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text('New Images:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        selectedImages.length,
                        (index) => Stack(
                          children: [
                            Image.file(
                              selectedImages[index],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: () {
                                  context.read<EditBannerBloc>().add(
                                        UpdateSelectedImagesEvent(
                                          List.from(selectedImages)
                                            ..removeAt(index),
                                        ),
                                      );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<EditBannerBloc>().add(
                        UpdateEditBannerEvent(
                          bannerId: banner['id'],
                          bannerName: bannerNameController.text.trim(),
                          images: selectedImages,
                          existingImages: existingImages,
                        ),
                      );
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Banners'),
        elevation: 0,
      ),
      body: BlocConsumer<EditBannerBloc, EditBannerState>(
        listener: (context, state) {
          if (state is EditBannerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is EditBannerImageUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is EditBannerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EditBannersLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.banners.length,
              itemBuilder: (context, index) {
                final banner = state.banners[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: banner['images'].isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.memory(
                              base64Decode(banner['images'][0]),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.image_not_supported, size: 60),
                    title: Text(
                      banner['bannerName'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${banner['images'].length} images'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => showEditDialog(banner),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Banner'),
                                content: const Text(
                                    'Are you sure you want to delete this banner?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<EditBannerBloc>().add(
                                            DeleteEditBannerEvent(banner['id']),
                                          );
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No banners available'));
        },
      ),
    );
  }

  @override
  void dispose() {
    bannerNameController.dispose();
    super.dispose();
  }
}
