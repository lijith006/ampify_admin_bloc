// import 'dart:convert';
// import 'dart:io';

// import 'package:ampify_admin_bloc/common/app_colors.dart';
// import 'package:ampify_admin_bloc/models/brand_model.dart';
// import 'package:ampify_admin_bloc/widgets/custom_button.dart';
// import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddBrand extends StatefulWidget {
//   AddBrand({super.key});

//   @override
//   State<AddBrand> createState() => _AddBrandState();
// }

// class _AddBrandState extends State<AddBrand> {
//   final TextEditingController brandNameController = TextEditingController();
//   XFile? selectedImage;
//   final ImagePicker _picker = ImagePicker();
//   // Function to pick an image from the gallery
//   Future<void> pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       selectedImage = image;
//     });
//   }

// // Function to encode the image to Base64-----
//   Future<String> _encodeImageToBase64(XFile image) async {
//     final bytes = await image.readAsBytes();
//     return base64Encode(
//         bytes); // Convert image bytes to Base64 string----------
//   }

// //check does brand exists
//   Future<bool> doesBrandExist(String brandName) async {
//     final existingBrands = await FirebaseFirestore.instance
//         .collection('brands')
//         .where('name', isEqualTo: brandName.trim())
//         .get();
//     return existingBrands.docs.isNotEmpty;
//   }

// // Function to add brand
//   Future<void> addBrand() async {
//     if (brandNameController.text.isEmpty || selectedImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Please fill all fields and select an image.')),
//       );
//       return;
//     }

//     try {
//       //check if the brand exists
//       final brandName = brandNameController.text.trim();
//       final brandExists = await doesBrandExist(brandName);
//       if (brandExists) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               backgroundColor: Colors.red,
//               content: Text('Brand already exists!')),
//         );
//         return;
//       }
//       //Encode image to base64
//       final base64Image = await _encodeImageToBase64(selectedImage!);

//       // Create Category object with a generated id
//       String brandId = FirebaseFirestore.instance.collection('brands').doc().id;

//       BrandModel brand = BrandModel(
//         id: brandId,
//         name: brandNameController.text.trim(),
//         image: base64Image,
//       );
//       print('Category Data: ${brand.toMap()}');

//       // Add category to Firestore
//       await FirebaseFirestore.instance
//           .collection('brands')
//           .doc(brandId)
//           .set(brand.toMap());

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Brand added successfully!')),
//       );

//       // Reset form
//       setState(() {
//         brandNameController.clear();
//         selectedImage = null;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error adding category: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,

//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         shadowColor: Colors.transparent,
//         title: const Text('Add brands'),
//       ),
//       //extendBodyBehindAppBar: true,
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   //image
//                   //*********************************************
//                   Container(
//                     height: 200,
//                     width: 200,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: selectedImage == null
//                         ? GestureDetector(
//                             onTap: pickImage,
//                             child: const Center(
//                               child: Icon(
//                                 Icons.add_a_photo_outlined,
//                                 size: 50,
//                               ),
//                             ),
//                           )
//                         : Stack(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.file(
//                                   File(selectedImage!.path),
//                                   fit: BoxFit.cover,
//                                   height: 200,
//                                   width: 200,
//                                 ),
//                               ),
//                               Positioned(
//                                 top: 4,
//                                 right: 4,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedImage = null;
//                                     });
//                                   },
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                       color: Colors.red,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: const Icon(
//                                       Icons.close,
//                                       color: Colors.white,
//                                       size: 20,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   //*********************************************** */
//                   CustomTextFormField(
//                       controller: brandNameController, labelText: 'Brand name'),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   CustomButton(
//                       label: 'Add brand',
//                       onTap: () {
//                         addBrand();
//                       })
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
