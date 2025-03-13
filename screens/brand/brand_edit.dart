// import 'dart:convert';
// import 'package:ampify_admin_bloc/common/app_colors.dart';
// import 'package:ampify_admin_bloc/models/brand_model.dart';
// import 'package:ampify_admin_bloc/widgets/custom_button.dart';
// import 'package:ampify_admin_bloc/widgets/custom_textformfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class EditBrandPage extends StatefulWidget {
//   final BrandModel brand;

//   const EditBrandPage({super.key, required this.brand});

//   @override
//   State<EditBrandPage> createState() => _EditBrandPageState();
// }

// class _EditBrandPageState extends State<EditBrandPage> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _nameController;
//   String? _imageBase64;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.brand.name);
//     _imageBase64 = widget.brand.image;
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();
//       setState(() {
//         _imageBase64 = base64Encode(bytes);
//       });
//     }
//   }

// //update
//   Future<void> _updateBrand() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await FirebaseFirestore.instance
//             .collection('brands')
//             .doc(widget.brand.id)
//             .update({
//           'name': _nameController.text,
//           'image': _imageBase64,
//         });
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Brand updated successfully!')),
//         );
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error updating brand: $e')),
//         );
//       }
//     }
//   }

// //Delete
//   Future<void> _deleteBrand() async {
//     try {
//       //Check if there is any product under brand
//       final productsSnapshot = await FirebaseFirestore.instance
//           .collection('products')
//           .where('brandId', isEqualTo: widget.brand.id)
//           .get();

//       if (productsSnapshot.docs.isNotEmpty) {
//         //show warning if not empty
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             backgroundColor: Colors.red,
//             content: Text(
//                 'Cannot delete brand:Product still exist under this brand')));
//         return;
//       }

//       await FirebaseFirestore.instance
//           .collection('brands')
//           .doc(widget.brand.id)
//           .delete();
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             backgroundColor: Colors.green,
//             content: Text('Brand deleted successfully!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             backgroundColor: Colors.red,
//             content: Text('Error deleting brand: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         title: const Text('Edit Brand'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: _imageBase64 == null
//                     ? Container(
//                         height: 150,
//                         width: 150,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.add_a_photo),
//                       )
//                     : ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.memory(
//                           base64Decode(_imageBase64!),
//                           height: 150,
//                           width: 150,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 20),
//               CustomTextFormField(
//                 controller: _nameController,
//                 labelText: 'Brand Name',
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the brand name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                       child:
//                           CustomButton(label: 'Update', onTap: _updateBrand)),
//                   const SizedBox(width: 10),
//                   Expanded(
//                       child:
//                           CustomButton(label: 'Delete', onTap: _deleteBrand)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
