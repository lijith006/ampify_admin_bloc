import 'dart:convert';
import 'dart:io';

import 'package:ampify_admin_bloc/screens/products/add_brand.dart';
import 'package:ampify_admin_bloc/screens/products/add_category.dart';
import 'package:ampify_admin_bloc/screens/products/product_list.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_text_styles.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();

  TextEditingController itemNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? selectedCategoryId;
  String? selectedBrandId;
  List<File> selectedImages = [];
  final List<XFile?> _pickedImages = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();

// Function to fetch categories from Firestore
  Stream<QuerySnapshot> _fetchCategories() {
    return _firestore.collection('categories').snapshots();
  }

  // Function to fetch brands from Firestore
  Stream<QuerySnapshot> _fetchBrands() {
    return _firestore.collection('brands').snapshots();
  }

  void _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && _pickedImages.length < 4) {
      setState(() {
        _pickedImages.add(pickedFile);

        // _pickedImages.add(pickedFile);
        selectedImages.add(File(pickedFile.path));
      });
    }
  }

  // Function to add product to Firestore
  Future<void> _addProduct() async {
    if (selectedCategoryId == null ||
        selectedBrandId == null ||
        itemNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        _pickedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and select images.')),
      );
      return;
    }

    // Encode image files to base64 strings (not ideal for large images)
    final List<String> imageUrls = _pickedImages.map((file) {
      final bytes = File(file!.path).readAsBytesSync();
      return "data:image/png;base64,${base64Encode(bytes)}";
    }).toList();

    try {
      // Add product to Firestore
      await _firestore.collection('products').add({
        'name': itemNameController.text.trim(),
        'categoryId': selectedCategoryId,
        'description': descriptionController.text.trim(),
        'price': double.parse(priceController.text.trim()),
        'brandId': selectedBrandId,
        'imageUrls': imageUrls,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );

      // Reset form
      setState(() {
        itemNameController.clear();
        descriptionController.clear();
        priceController.clear();
        _pickedImages.clear();

        selectedCategoryId = null;
        selectedBrandId = null;
        selectedImages = [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding product: $e')),
      );
    }
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  //Product Image
                  Text(
                    'Add products',
                    style: CustomTextStyles.boldTextFieldStyle(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Image Picker Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Max 4 items per row
                      crossAxisSpacing: 8, // Horizontal spacing
                      mainAxisSpacing: 8, // Vertical spacing
                    ),
                    itemCount: selectedImages.length < 4
                        ? selectedImages.length + 1
                        : 4, // Include Add button if images < 4
                    itemBuilder: (context, index) {
                      if (index == selectedImages.length &&
                          selectedImages.length < 4) {
                        // Add Photo Button
                        return GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.grey),
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
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.8),
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
                  const SizedBox(
                    height: 16,
                  ),

                  //itemName
                  CustomTextFormField(
                    controller: itemNameController,
                    labelText: 'Product name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a product name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  //Product description

                  CustomTextFormField(
                    maxLines: 4,
                    controller: descriptionController,
                    labelText: 'Product description',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a product description.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  //product price
                  CustomTextFormField(
                    controller: priceController,
                    labelText: 'Product price',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a product price.";
                      }
                      if (double.tryParse(value) == null) {
                        return "Please enter a valid price.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  //DROP doWn
                  // Category Dropdown
                  StreamBuilder<QuerySnapshot>(
                    stream: _fetchCategories(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return DropdownButtonFormField<String>(
                        value: selectedCategoryId,
                        items: snapshot.data!.docs.map((doc) {
                          return DropdownMenuItem(
                            value: doc.id,
                            child: Text(doc['name']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategoryId = value!;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: 'Select Category'),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // Brand Dropdown
                  StreamBuilder<QuerySnapshot>(
                    stream: _fetchBrands(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return DropdownButtonFormField<String>(
                        value: selectedBrandId,
                        items: snapshot.data!.docs.map((doc) {
                          return DropdownMenuItem(
                            value: doc.id,
                            child: Text(doc['name']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedBrandId = value!;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: 'Select Brand'),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  const SizedBox(height: 24),

                  CustomButton(
                      label: 'Add Category',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddCategory(),
                            ));
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      label: 'Add Brand',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddBrand(),
                            ));
                      }),
                  const SizedBox(
                    height: 20,
                  ),

                  //SUBMIT
                  CustomButton(
                      label: 'Add Product',
                      onTap: () {
                        _addProduct();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      label: 'Product List',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductListPage(),
                            ));
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
