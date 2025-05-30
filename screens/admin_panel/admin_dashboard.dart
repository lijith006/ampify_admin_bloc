// import 'package:ampify_admin_bloc/screens/chat_screen/chat_screen/chat_list_screen.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../authentication/screens/login_screen.dart';
// import '../../banner/add_banner/add_banner_screen/add banner.dart';
// import '../../banner/edit_banner/edit_banner_screen/edit_banner.dart';
// import '../../common/app_colors.dart';
// import '../../common/custom_text_styles.dart';
// import '../../widgets/admin_dashboard/dashboard_grid.dart';
// import '../brands/add_brands/bloc/screen/brand_add_screen.dart';
// import '../brands/brands_list/brand_list_screen.dart';
// import '../categories/add_categories/bloc/add_category_screen.dart';
// import '../categories/categories_list/categories_list_screens/categories_list_screen.dart';
// import '../order_details_screen/all_orders_screen.dart';
// import '../productss/add_products/add-product_screen/add_product_screen.dart';
// import '../productss/products_list/product_list_screen/product_list_screen.dart';

// class AdminDashboard extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   void signOutConfirmation(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               backgroundColor: Colors.white,
//               elevation: 8,
//               title: const Text(
//                 'Confirm Sign Out',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.black,
//                 ),
//               ),
//               content: const Text(
//                 'Are you sure you want to sign out?',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black87,
//                 ),
//               ),
//               actions: [
//                 // Cancel button
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 // Confirm button
//                 ElevatedButton(
//                   onPressed: () {
//                     signOut(); // sign out function
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Signed out successfully!'),
//                         duration: Duration(seconds: 2),
//                         behavior: SnackBarBehavior.floating,
//                       ),
//                     );
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const LoginScreen()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 20),
//                     elevation: 5,
//                   ),
//                   child: const Text(
//                     'Confirm',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ));
//   }

//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       print("Something went wrong");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> features = [
//       {
//         'title': 'Add Brand',
//         'icon': Icons.branding_watermark,
//         'onTap': () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => AddBrand()));
//         }
//       },
//       {
//         'title': 'Add Category',
//         'icon': Icons.category,
//         'onTap': () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => AddCategoryScreen()));
//         }
//       },
//       {
//         'title': 'Add Product',
//         'icon': Icons.add_shopping_cart,
//         'onTap': () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => AddProduct()));
//         }
//       },
//       {
//         'title': 'Product List',
//         'icon': Icons.list,
//         'onTap': () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const ProductListPage()));
//         }
//       },
//       {
//         'title': 'Edit Brand',
//         'icon': Icons.edit,
//         'onTap': () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const BrandList()));
//         }
//       },
//       {
//         'title': 'Edit Category',
//         'icon': Icons.edit,
//         'onTap': () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const CategoriesList()));
//         }
//       },
//       {
//         'title': 'Add Banner',
//         'icon': Icons.add_box_outlined,
//         'onTap': () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const AddBanner()));
//         }
//       },
//       {
//         'title': 'Edit Banner',
//         'icon': Icons.edit_document,
//         'onTap': () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const EditBannerScreen()));
//         }
//       },
//       {
//         'title': 'Orders',
//         'icon': Icons.format_list_numbered_rtl_outlined,
//         'onTap': () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => AdminOrderScreen(
//                         revenueData: _extractRevenueData(context),
//                       )));
//         }
//       },
//       {
//         'title': 'Chats',
//         'icon': Icons.chat_outlined,
//         'onTap': () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => AdminChatListScreen()));
//         }
//       },
//     ];

//     return Scaffold(
//       backgroundColor: AppColors.backgroundColorLight,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Dashboard',
//           style: CustomTextStyles.heading2(),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 signOutConfirmation(context);
//               },
//               icon: const Icon(Icons.logout))
//         ],
//       ),
//       body: AdminDashboardGrid(features: features),
//     );
//   }

//   List<double> _extractRevenueData(BuildContext context) {
//     final state = context.read<OrderBloc>().state;
//     if (state is OrdersLoaded) {
//       return state.orders.map((order) => order.totalAmount).toList();
//     }
//     return [];
//   }
// }
//-------------------------------------------------------------------------------------------------------------
import 'package:ampify_admin_bloc/screens/chat_screen/chat_screen/chat_list_screen.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
import 'package:ampify_admin_bloc/widgets/admin_dashboard/animated_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/screens/login_screen.dart';
import '../../banner/add_banner/add_banner_screen/add banner.dart';
import '../../banner/edit_banner/edit_banner_screen/edit_banner.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text_styles.dart';
// import '../../widgets/admin_dashboard/dashboard_grid.dart';
import '../brands/add_brands/bloc/screen/brand_add_screen.dart';
import '../brands/brands_list/brand_list_screen.dart';
import '../categories/add_categories/bloc/add_category_screen.dart';
import '../categories/categories_list/categories_list_screens/categories_list_screen.dart';
import '../order_details_screen/all_orders_screen.dart';
import '../productss/add_products/add-product_screen/add_product_screen.dart';
import '../productss/products_list/product_list_screen/product_list_screen.dart';

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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCategoryScreen()));
        }
      },
      {
        'title': 'Add Product',
        'icon': Icons.add_shopping_cart,
        'onTap': () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
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
      {
        'title': 'Edit Banner',
        'icon': Icons.edit_document,
        'onTap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditBannerScreen()));
        }
      },
      {
        'title': 'Orders',
        'icon': Icons.format_list_numbered_rtl_outlined,
        'onTap': () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminOrderScreen(
                        revenueData: _extractRevenueData(context),
                      )));
        }
      },
      {
        'title': 'Chats',
        'icon': Icons.chat_outlined,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminChatListScreen()));
        }
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
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
      // body: AdminDashboardGrid(features: features),
      body: LayoutBuilder(builder: (context, constraints) {
        int columns = 4; //default
        if (constraints.maxWidth < 600) {
          columns = 2;
        } else if (constraints.maxWidth < 1200) {
          columns = 3;
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                return FeatureCard(
                  title: features[index]['title'],
                  icon: features[index]['icon'],
                  onTap: features[index]['onTap'],
                );
              }),
        );
      }),
    );
  }

  List<double> _extractRevenueData(BuildContext context) {
    final state = context.read<OrderBloc>().state;
    if (state is OrdersLoaded) {
      return state.orders.map((order) => order.totalAmount).toList();
    }
    return [];
  }
}
