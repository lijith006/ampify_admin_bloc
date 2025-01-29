import 'dart:convert';
import 'dart:io';

import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/models/category_model.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController categoryNameController = TextEditingController();
  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();

  // pick  image from the gallery
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = image;
    });
  }

  // Encode the image to Base64
  Future<String> _encodeImageToBase64(XFile image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes); // Convert image bytes to Base64 string
  }

//  add category
  Future<void> _addCategory() async {
    if (categoryNameController.text.isEmpty || selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and select an image.')),
      );
      return;
    }

    try {
      final base64Image = await _encodeImageToBase64(selectedImage!);

      String categoryId =
          FirebaseFirestore.instance.collection('categories').doc().id;

      Category category = Category(
        id: categoryId,
        name: categoryNameController.text.trim(),
        image: base64Image,
      );
      print('Category Data: ${category.toMap()}');

      // Add category to Firestore
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .set(category.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category added successfully!')),
      );

      // Reset form
      setState(() {
        categoryNameController.clear();
        selectedImage = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding category: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: const Text('Add categories'),
      ),
      // extendBodyBehindAppBar: true,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //image
                  //*********************************************
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: selectedImage == null
                        ? GestureDetector(
                            onTap: pickImage,
                            child: const Center(
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                size: 50,
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(selectedImage!.path),
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImage = null;
                                    });
                                  },
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
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //*********************************************** */
                  CustomTextFormField(
                      controller: categoryNameController,
                      labelText: 'Category name'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      label: 'Add category',
                      onTap: () {
                        _addCategory();
                        print('Category Name: ${categoryNameController.text}');
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
