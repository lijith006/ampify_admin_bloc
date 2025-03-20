import 'dart:convert';
import 'package:ampify_admin_bloc/screens/productss/products_details/product_detail_screen/product_details_screen.dart';
import 'package:ampify_admin_bloc/screens/productss/products_list/bloc/product_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/screens/productss/edit_products/bloc/edit_product_screen/edit_product_screen.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListBloc()..add(FetchProducts()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColorLight,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          title: const Text('Product Lists'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductListError) {
                return Center(child: Text(state.message));
              } else if (state is ProductListLoaded) {
                final products = state.products;
                if (products.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final productId = products[index].id;
                    return Card(
                      child: ListTile(
                        leading: product['images'] != null &&
                                product['images'].isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  const Base64Decoder()
                                      .convert(product['images'][0]),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : const Icon(Icons.image),
                        title: Text(product['name'] ?? "Unnamed Product"),
                        subtitle: Text("\₹${product['price'] ?? '0.00'}"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailPage(productId: productId),
                              ));
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: AppColors.outLineColor),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProductPage(product),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _deleteProduct(context, product.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(child: Text('Something went wrong!'));
            },
          ),
        ),
      ),
    );
  }

  Future<void> _deleteProduct(BuildContext context, String productId) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmation == true) {
      context.read<ProductListBloc>().add(DeleteProduct(productId));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product deleted successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
