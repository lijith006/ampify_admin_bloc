import 'dart:convert';
import 'dart:typed_data';

import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/screens/productss/products_details/bloc/product_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clippy_flutter/arc.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailBloc()..add(FetchProductDetails(productId)),
      child: Scaffold(
        backgroundColor: AppColors.light,
        appBar: AppBar(
          title: const Text("Product Details"),
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailError) {
              return Center(child: Text(state.message));
            } else if (state is ProductDetailLoaded) {
              return _buildProductDetail(context, state);
            }
            return const Center(child: Text('Something went wrong!'));
          },
        ),
      ),
    );
  }

  Widget _buildProductDetail(BuildContext context, ProductDetailLoaded state) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider.builder(
            itemCount: state.images.length,
            options: CarouselOptions(
              height: 320,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.85,
            ),
            itemBuilder: (context, index, realIndex) {
              Uint8List imageBytes = base64Decode(state.images[index]);
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          const SizedBox(height: 30),
          Arc(
            height: 30,
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            child: Container(
              width: double.infinity,
              // color: const Color.fromARGB(255, 24, 63, 5),
              color: AppColors.clr,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: AppColors.outLineColor,
                              // color: Colors.white,
                            ),
                          ),
                          Text(
                            " \₹${state.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: AppColors.outLineColor,

                              // color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: screenWidth * 10,
            height: screenHeight * 0.32,
            color: const Color(0XFF202224),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    state.description,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
