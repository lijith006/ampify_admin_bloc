// import 'dart:convert';

// import 'package:ampify_admin_bloc/common/app_colors.dart';
// import 'package:ampify_admin_bloc/models/brand_model.dart';
// import 'package:ampify_admin_bloc/screens/brands/edit_brands/edit_brand_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class BrandList extends StatefulWidget {
//   const BrandList({super.key});

//   @override
//   State<BrandList> createState() => _BrandListState();
// }

// class _BrandListState extends State<BrandList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         shadowColor: Colors.transparent,
//         title: const Text('Brands'),
//       ),
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance.collection('brands').snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return const Center(child: Text('No products available.'));
//               }
//               final brands = snapshot.data!.docs.map((doc) {
//                 return BrandModel.fromMap(doc.data() as Map<String, dynamic>);
//               }).toList();
//               return GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 3 / 4,
//                 ),
//                 itemCount: brands.length,
//                 itemBuilder: (context, index) {
//                   final brand = brands[index];
//                   return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => EditBrandPage(brand: brand),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         //color: AppColors.outLineColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         elevation: 5,
//                         child: Column(
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                 ),
//                                 child: Image.memory(
//                                   base64Decode(brand.image),
//                                   fit: BoxFit.cover,
//                                   width: double.infinity,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Center(
//                                 child: Text(
//                                   brand.name,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ));
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
