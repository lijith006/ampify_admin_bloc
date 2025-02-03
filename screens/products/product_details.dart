// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ProductDetailPage extends StatelessWidget {
//   final String productId;

//   const ProductDetailPage({super.key, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Product Details")),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance
//             .collection('products')
//             .doc(productId)
//             .get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return const Center(child: Text("Product not found"));
//           }

//           final productData = snapshot.data!.data() as Map<String, dynamic>;

//           List<String> base64Images =
//               List<String>.from(productData['images'] ?? []);

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Product Name
//                 Text(
//                   productData['name'] ?? 'No Name',
//                   style: const TextStyle(
//                       fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),

//                 // Price
//                 Text(
//                   "Price: \$${productData['price'] ?? '0.00'}",
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 10),

//                 // Product Description
//                 Text(
//                   productData['description'] ?? 'No description available',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 20),

//                 // Display Images (Convert Base64 to Image)
//                 if (base64Images.isNotEmpty)
//                   SizedBox(
//                     height: 200, // Adjust size as needed
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: base64Images.length,
//                       itemBuilder: (context, index) {
//                         Uint8List imageBytes =
//                             base64Decode(base64Images[index]);
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.memory(imageBytes,
//                                 fit: BoxFit.cover, width: 200, height: 200),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 else
//                   const Center(child: Text("No images available")),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//************************************************************** */
import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentIndex = 0;
  List<String> base64Images = [];
  String productName = "";
  String productDescription = "";
  double productPrice = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .get();

      if (snapshot.exists) {
        final productData = snapshot.data() as Map<String, dynamic>;
        setState(() {
          base64Images = List<String>.from(productData['images'] ?? []);
          productName = productData['name'] ?? "No Name";
          productDescription =
              productData['description'] ?? "No description available";
          productPrice = (productData['price'] ?? 0.0).toDouble();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching products details:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: Colors.transparent,
      ),
      body: base64Images.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: base64Images.length,
                    options: CarouselOptions(
                      height: 320,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.85,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      Uint8List imageBytes = base64Decode(base64Images[index]);
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Arc(
                    height: 30,
                    edge: Edge.TOP,
                    arcType: ArcType.CONVEY,
                    child: Container(
                      width: double.infinity,
                      // color: const Color(0XFF526664),
                      color: Color.fromARGB(255, 24, 63, 5),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 50, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(productName,
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white)),
                                  Text(
                                    " \₹${productPrice.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 10,
                    height: screenHeight * 0.32,
                    // color: Color(0XFF365b5b),
                    // color: Color(0XFF526664),
                    color: Color(0XFF202224),

                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),

                          // Product Description
                          Text(
                            productDescription,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          //),

                          // Price
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
