// import 'package:ampify_admin_bloc/authentication/bloc/auth_bloc.dart';
import 'package:ampify_admin_bloc/authentication/screens/login_screen.dart';
import 'package:ampify_admin_bloc/screens/brand/brand_edit.dart';
import 'package:ampify_admin_bloc/screens/categories/categories_edit.dart';
import 'package:ampify_admin_bloc/screens/products/add_brand.dart';
import 'package:ampify_admin_bloc/screens/products/add_category.dart';
import 'package:ampify_admin_bloc/screens/products/add_product.dart';
import 'package:ampify_admin_bloc/screens/products/product_list.dart';
import 'package:ampify_admin_bloc/widgets/admin_dashboard/dashboard_grid.dart';
import 'package:ampify_admin_bloc/widgets/custom_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close the dialog
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Signed out successfully!'),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'title': 'Add Brand',
        'icon': Icons.branding_watermark,
        'onTap': () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddBrand()));
        }
      },
      {
        'title': 'Add Category',
        'icon': Icons.category,
        'onTap': () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCategory()));
        }
      },
      {
        'title': 'Add Product',
        'icon': Icons.add_shopping_cart,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddProduct()));
        }
      },
      {
        'title': 'Product List',
        'icon': Icons.list,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProductListPage()));
        }
      },
      {
        'title': 'Edit Brand',
        'icon': Icons.edit,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BrandEditScreen()));
        }
      },
      {
        'title': 'Edit Category',
        'icon': Icons.edit,
        'onTap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CategoryEditScreen()));
        }
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: CustomTextStyles.heading2(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                signOutConfirmation(context);
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const LoginScreen(),

                //   ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: AdminDashboardGrid(features: features),
    );
  }
}
