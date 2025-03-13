import 'dart:convert';
import 'package:ampify_admin_bloc/screens/brands/brands_list/bloc/brand_list_bloc.dart';
import 'package:ampify_admin_bloc/screens/brands/brands_list/bloc/brand_list_event.dart';
import 'package:ampify_admin_bloc/screens/brands/brands_list/bloc/brand_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/screens/brands/edit_brands/edit_brand_screen.dart';

class BrandList extends StatelessWidget {
  const BrandList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrandListBloc()..add(LoadBrands()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColorLight,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          title: const Text('Brands'),
        ),
        body: BlocBuilder<BrandListBloc, BrandListState>(
          builder: (context, state) {
            if (state is BrandListLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BrandListErrorState) {
              return Center(child: Text(state.errorMessage));
            } else if (state is BrandListLoadedState) {
              final brands = state.brands;
              if (brands.isEmpty) {
                return const Center(child: Text('No brands available.'));
              }

              return Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: brands.length,
                  itemBuilder: (context, index) {
                    final brand = brands[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditBrandPage(brand: brand),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.memory(
                                  base64Decode(brand.image),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  brand.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return const Center(child: Text('Unexpected State!'));
          },
        ),
      ),
    );
  }
}
