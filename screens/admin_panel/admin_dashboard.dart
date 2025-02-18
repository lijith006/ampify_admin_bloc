import 'package:ampify_admin_bloc/authentication/screens/login_screen.dart';
import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/screens/brand/brand_list.dart';
import 'package:ampify_admin_bloc/screens/categories/categories_list.dart';
import 'package:ampify_admin_bloc/screens/products/add%20banner.dart';
import 'package:ampify_admin_bloc/screens/products/add_brand.dart';
import 'package:ampify_admin_bloc/screens/products/add_category.dart';
import 'package:ampify_admin_bloc/screens/products/add_product.dart';
import 'package:ampify_admin_bloc/screens/products/product_list.dart';
import 'package:ampify_admin_bloc/widgets/admin_dashboard/dashboard_grid.dart';
import 'package:ampify_admin_bloc/common/custom_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOutConfirmation(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.white,
              elevation: 8,
              title: const Text(
                'Confirm Sign Out',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              content: const Text(
                'Are you sure you want to sign out?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              actions: [
                // Cancel button
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                // Confirm button
                ElevatedButton(
                  onPressed: () {
                    signOut(); // sign out function
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Signed out successfully!'),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ));
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
              MaterialPageRoute(builder: (context) => const BrandList()));
        }
      },
      {
        'title': 'Edit Category',
        'icon': Icons.edit,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CategoriesList()));
        }
      },
      {
        'title': 'Add Banner',
        'icon': Icons.add_box_outlined,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddBanner()));
        }
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Dashboard',
          style: CustomTextStyles.heading2(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                signOutConfirmation(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: AdminDashboardGrid(features: features),
    );
  }
}
