import 'dart:convert';
import 'dart:io';

import 'package:ampify_admin_bloc/models/products_model.dart';
import 'package:ampify_admin_bloc/screens/products/add_brand.dart';
import 'package:ampify_admin_bloc/screens/products/add_category.dart';
import 'package:ampify_admin_bloc/screens/products/product_list.dart';
import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/widgets/custom_text_styles.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

// Function to compress and convert image to Base64
  Future<String> compressAndConvertToBase64(File image) async {
    // Compress the image
    final compressedImage = await FlutterImageCompress.compressWithFile(
      image.absolute.path,
      minWidth: 500,
      minHeight: 500,
      quality: 80,
    );

    // Convert the compressed image to Base64
    final base64Image = base64Encode(compressedImage!);
    return base64Image;
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

    try {
      //ID
      // final String productId = _firestore.collection('products').doc().id;
      // // Convert images to Base64 strings
      // final List<String> base64Images = [];
      // for (var image in selectedImages) {
      //   final bytes = await image.readAsBytes();
      //   final base64Image = base64Encode(bytes);
      //   base64Images.add(base64Image);
      // }
      final String productId = _firestore.collection('products').doc().id;
      // Convert images to Base64 strings
      final List<String> base64Images = [];
      for (var image in selectedImages) {
        String base64Image = await compressAndConvertToBase64(image);
        base64Images.add(base64Image);
      }

      // Create product instance
      final product = Product(
        id: productId,
        name: itemNameController.text.trim(),
        price: double.parse(priceController.text.trim()),
        description: descriptionController.text.trim(),
        categoryId: selectedCategoryId!,
        brandId: selectedBrandId!,
        image: base64Images.join(','),
        createdAt: null,
      );
      // Add product to Firestore
      await _firestore
          .collection('products')
          .doc(productId)
          .set(product.toMap());

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
        selectedImages.clear();
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
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: selectedImages.length < 4
                        ? selectedImages.length + 1
                        : 4, // will show add button if images less than 4
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
