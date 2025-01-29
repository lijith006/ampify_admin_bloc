// import 'dart:convert';
// import 'dart:io';

// import 'package:ampify_admin_bloc/widgets/custom_button.dart';
// import 'package:ampify_admin_bloc/widgets/custom_text_styles.dart';
// import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_picker/image_picker.dart';

// class EditProductPage extends StatefulWidget {
//   final QueryDocumentSnapshot product;

//   const EditProductPage(this.product, {super.key});

//   @override
//   State<EditProductPage> createState() => _EditProductPageState();
// }

// class _EditProductPageState extends State<EditProductPage> {
//   final formKey = GlobalKey<FormState>();

//   late TextEditingController itemNameController;
//   late TextEditingController priceController;
//   late TextEditingController descriptionController;
//   final _firestore = FirebaseFirestore.instance;
//   String? selectedCategoryId;
//   String? selectedBrandId;
//   List<File> selectedImages = [];
//   final _imagePicker = ImagePicker();
// //***************************************************************** */

//   //Remove image
//   void removeImage(int index) {
//     setState(() {
//       selectedImages.removeAt(index);
//     });
//   }

//   //************************************************************* */
//   @override
//   void initState() {
//     super.initState();

//     itemNameController = TextEditingController(text: widget.product['name']);
//     priceController =
//         TextEditingController(text: widget.product['price'].toString());
//     descriptionController =
//         TextEditingController(text: widget.product['description']);
//     selectedCategoryId = widget.product['categoryId'];
//     selectedBrandId = widget.product['brandId'];
//     // Load existing images
//     if (widget.product['images'] != null) {
//       final images = List<String>.from(widget.product['images']);
//       for (var image in images) {
//         try {
//           final bytes = base64Decode(image);
//           selectedImages.add(File.fromRawPath(bytes));
//         } catch (e) {
//           debugPrint('Failed to decode image: $e');
//         }
//       }
//     }
//   }

//   // Function to compress and convert image to Base64
//   Future<String> compressImage(File image) async {
//     final compressed = await FlutterImageCompress.compressWithFile(
//       image.path,
//       minWidth: 500,
//       minHeight: 500,
//       quality: 80,
//     );
//     return base64Encode(compressed!);
//   }

//   void _pickImage() async {
//     final pickedFile =
//         await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         selectedImages.add(File(pickedFile.path));
//       });
//     }
//   }

//   Future<void> _updateProduct() async {
//     if (formKey.currentState!.validate()) {
//       try {
//         // Compress and prepare images
//         List<String> imagesBase64 = [];
//         for (var image in selectedImages) {
//           final base64Image = await compressImage(image);
//           imagesBase64.add(base64Image);
//         }

//         // Update Firestore
//         await _firestore.collection('products').doc(widget.product.id).update({
//           'name': itemNameController.text.trim(),
//           'price': double.parse(priceController.text.trim()),
//           'description': descriptionController.text.trim(),
//           'categoryId': selectedCategoryId,
//           'brandId': selectedBrandId,
//           'images': imagesBase64,
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Product updated successfully!')),
//         );

//         Navigator.pop(context);
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to update product: $e'),
//           ),
//         );
//       }
//     }
//   }

//   // Function to fetch categories from Firestore
//   Stream<QuerySnapshot> _fetchCategories() {
//     return _firestore.collection('categories').snapshots();
//   }

//   // Function to fetch brands from Firestore
//   Stream<QuerySnapshot> _fetchBrands() {
//     return _firestore.collection('brands').snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         shadowColor: Colors.transparent,
//       ),
//       extendBodyBehindAppBar: true,
//       body: SingleChildScrollView(
//         child: Container(
//           // height: MediaQuery.of(context).size.height,
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/images/background.jpg'),
//                   fit: BoxFit.cover)),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 60,
//                   ),
//                   //Product Image
//                   Text(
//                     'Edit products',
//                     style: CustomTextStyles.boldTextFieldStyle(),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),

//                   // Image Picker Grid
//                   GridView.builder(
//                     shrinkWrap: true,
//                     itemCount: selectedImages.length + 1,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       crossAxisSpacing: 8,
//                       mainAxisSpacing: 8,
//                     ),
//                     itemBuilder: (context, index) {
//                       if (index == selectedImages.length) {
//                         return GestureDetector(
//                           onTap: _pickImage,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: const Icon(Icons.add_a_photo),
//                           ),
//                         );
//                       }
//                       final image = selectedImages[index];
//                       return Stack(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Image.file(image, fit: BoxFit.cover),
//                           ),
//                           Positioned(
//                             top: 4,
//                             right: 4,
//                             child: GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedImages.removeAt(index);
//                                 });
//                               },
//                               child: Container(
//                                 decoration: const BoxDecoration(
//                                   color: Colors.red,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   Icons.close,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),

//                   //itemName
//                   CustomTextFormField(
//                     controller: itemNameController,
//                     labelText: 'Product name',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter a product name.";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   //Product description

//                   CustomTextFormField(
//                     maxLines: 4,
//                     controller: descriptionController,
//                     labelText: 'Product description',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter a product description.";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   //product price
//                   CustomTextFormField(
//                     controller: priceController,
//                     labelText: 'Product price',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter a product price.";
//                       }
//                       if (double.tryParse(value) == null) {
//                         return "Please enter a valid price.";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   //DROP doWn
//                   // Category Dropdown
//                   StreamBuilder<QuerySnapshot>(
//                     stream: _fetchCategories(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return const CircularProgressIndicator();
//                       }
//                       return DropdownButtonFormField<String>(
//                         value: selectedCategoryId,
//                         items: snapshot.data!.docs.map((doc) {
//                           return DropdownMenuItem(
//                             value: doc.id,
//                             child: Text(doc['name']),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedCategoryId = value!;
//                           });
//                         },
//                         decoration:
//                             const InputDecoration(labelText: 'Select Category'),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   // Brand Dropdown
//                   StreamBuilder<QuerySnapshot>(
//                     stream: _fetchBrands(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return const CircularProgressIndicator();
//                       }
//                       return DropdownButtonFormField<String>(
//                         value: selectedBrandId,
//                         items: snapshot.data!.docs.map((doc) {
//                           return DropdownMenuItem(
//                             value: doc.id,
//                             child: Text(doc['name']),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedBrandId = value!;
//                           });
//                         },
//                         decoration:
//                             const InputDecoration(labelText: 'Select Brand'),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   const SizedBox(height: 24),

//                   const SizedBox(
//                     height: 20,
//                   ),

//                   //SUBMIT
//                   CustomButton(
//                       label: 'Add Product',
//                       onTap: () {
//                         _updateProduct();
//                       }),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ampify_admin_bloc/widgets/custom_button.dart';
import 'package:ampify_admin_bloc/common/custom_text_styles.dart';
import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class EditProductPage extends StatefulWidget {
  final QueryDocumentSnapshot product;

  const EditProductPage(
    this.product, {
    super.key,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController itemNameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  final _firestore = FirebaseFirestore.instance;
  String? selectedCategoryId;
  String? selectedBrandId;
  List<File> selectedImages = [];
  final _imagePicker = ImagePicker();
//***************************************************************** */

  //Remove image
  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  //************************************************************* */
  @override
  void initState() {
    super.initState();

    itemNameController = TextEditingController(text: widget.product['name']);
    priceController =
        TextEditingController(text: widget.product['price'].toString());
    descriptionController =
        TextEditingController(text: widget.product['description']);
    selectedCategoryId = widget.product['categoryId'];
    selectedBrandId = widget.product['brandId'];
    // Load existing images
    if (widget.product['images'] != null) {
      final images = List<String>.from(widget.product['images']);
      for (var image in images) {
        try {
          final bytes = base64Decode(image);
          selectedImages.add(File.fromRawPath(Uint8List.fromList(bytes)));
        } catch (e) {
          debugPrint('Failed to decode image: $e');
        }
      }
    }
  }

  // Function to compress and convert image to Base64
  Future<String> compressImage(File image) async {
    final compressed = await FlutterImageCompress.compressWithFile(
      image.path,
      minWidth: 500,
      minHeight: 500,
      quality: 80,
    );
    return base64Encode(compressed!);
  }

  void _pickImage() async {
    if (selectedImages.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only add up to 4 images.')),
      );
      return;
    }
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _updateProduct() async {
    if (formKey.currentState!.validate()) {
      try {
        // Compress and prepare images
        List<String> imagesBase64 = [];
        for (var image in selectedImages) {
          final base64Image = await compressImage(image);
          imagesBase64.add(base64Image);
        }

        // Update Firestore
        await _firestore.collection('products').doc(widget.product.id).update({
          'name': itemNameController.text.trim(),
          'price': double.parse(priceController.text.trim()),
          'description': descriptionController.text.trim(),
          'categoryId': selectedCategoryId,
          'brandId': selectedBrandId,
          'images': imagesBase64,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product updated successfully!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update product: $e'),
          ),
        );
      }
    }
  }

  // Function to fetch categories from Firestore
  Stream<QuerySnapshot> _fetchCategories() {
    return _firestore.collection('categories').snapshots();
  }

  // Function to fetch brands from Firestore
  Stream<QuerySnapshot> _fetchBrands() {
    return _firestore.collection('brands').snapshots();
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
          // height: MediaQuery.of(context).size.height,
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
                    'Edit products',
                    style: CustomTextStyles.boldTextFieldStyle(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Image Picker Grid
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: selectedImages.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      if (index == selectedImages.length) {
                        return GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add_a_photo),
                          ),
                        );
                      }
                      final image = selectedImages[index];
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.file(image, fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImages.removeAt(index);
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

                  const SizedBox(
                    height: 20,
                  ),

                  //SUBMIT
                  CustomButton(
                      label: 'Add Product',
                      onTap: () {
                        _updateProduct();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
