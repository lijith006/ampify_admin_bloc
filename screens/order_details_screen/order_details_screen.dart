// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_event.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
// import 'package:ampify_admin_bloc/widgets/custom_app_bar.dart';
// import 'package:ampify_admin_bloc/widgets/order_timeline.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/order_model/order_model.dart';
// import 'package:ampify_admin_bloc/common/app_colors.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// class AdminOrderDetailsScreen extends StatefulWidget {
//   final OrderModel order;

//   const AdminOrderDetailsScreen({super.key, required this.order});

//   @override
//   State<AdminOrderDetailsScreen> createState() =>
//       _AdminOrderDetailsScreenState();
// }

// class _AdminOrderDetailsScreenState extends State<AdminOrderDetailsScreen> {
//   late Stream<DocumentSnapshot> _orderStream;

//   @override
//   void initState() {
//     super.initState();
//     // Listen for real-time updates to the order document
//     _orderStream = FirebaseFirestore.instance
//         .collection('orders')
//         .doc(widget.order.id)
//         .snapshots();
//   }

//   // Format the createdAt timestamp
//   String formatDate(Timestamp timestamp) {
//     final dateFormat = DateFormat('MMM dd, yyyy hh:mm a');
//     return dateFormat.format(timestamp.toDate());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColorLight,
//       appBar: const CustomAppBar(
//         title: 'Order Details',
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: StreamBuilder<DocumentSnapshot>(
//             stream: _orderStream,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (!snapshot.hasData || !snapshot.data!.exists) {
//                 return const Center(child: Text('Order not found'));
//               }

//               final orderData = snapshot.data!.data() as Map<String, dynamic>;
//               final updatedOrder =
//                   OrderModel.fromMap(widget.order.id, orderData);

//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Order Details
//                   Card(
//                     color: AppColors.backgroundColorLight,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Order #${updatedOrder.id}",
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Ordered on: ${formatDate(updatedOrder.createdAt)}",
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Total: \₹${updatedOrder.totalAmount}",
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Delivery Address: ${updatedOrder.address}",
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Hint Text
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       "Tap on a status to update the order:",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   BlocBuilder<OrderBloc, OrderState>(
//                     builder: (context, state) {
//                       return Column(
//                         children: [
//                           OrderTimeline(
//                             status: "Pending",
//                             isFirst: true,
//                             isActive: updatedOrder.status == "Pending",
//                             icon: Icons.shopping_cart,
//                             description: "Your order has been placed.",
//                             animationPath:
//                                 'assets/animations/order_placed.json',
//                             onTap: () {
//                               context.read<OrderBloc>().add(
//                                     UpdateOrderStatus(
//                                       orderId: updatedOrder.id,
//                                       newStatus: "Pending",
//                                     ),
//                                   );
//                             },
//                             trailing: const Icon(
//                               Icons.touch_app,
//                               color: Colors.grey,
//                               size: 16,
//                             ),
//                           ),
//                           OrderTimeline(
//                             status: "Processing",
//                             isActive: updatedOrder.status == "Processing",
//                             icon: Icons.build,
//                             description: "Your order is being processed.",
//                             animationPath:
//                                 'assets/animations/order_processing.json',
//                             onTap: () {
//                               context.read<OrderBloc>().add(
//                                     UpdateOrderStatus(
//                                       orderId: updatedOrder.id,
//                                       newStatus: "Processing",
//                                     ),
//                                   );
//                             },
//                             trailing: const Icon(
//                               Icons.touch_app,
//                               color: Colors.grey,
//                               size: 16,
//                             ),
//                           ),
//                           OrderTimeline(
//                             status: "Shipped",
//                             isActive: updatedOrder.status == "Shipped",
//                             icon: Icons.local_shipping,
//                             description: "Your order has been shipped.",
//                             animationPath:
//                                 'assets/animations/order_shipped.json',
//                             onTap: () {
//                               context.read<OrderBloc>().add(
//                                     UpdateOrderStatus(
//                                       orderId: updatedOrder.id,
//                                       newStatus: "Shipped",
//                                     ),
//                                   );
//                             },
//                             trailing: const Icon(
//                               Icons.touch_app,
//                               color: Colors.grey,
//                               size: 16,
//                             ),
//                           ),
//                           OrderTimeline(
//                             status: "Delivered",
//                             isActive: updatedOrder.status == "Delivered",
//                             icon: Icons.check_circle,
//                             description: "Your order has been delivered.",
//                             animationPath:
//                                 'assets/animations/order_delivered.json',
//                             onTap: () {
//                               context.read<OrderBloc>().add(
//                                     UpdateOrderStatus(
//                                       orderId: updatedOrder.id,
//                                       newStatus: "Delivered",
//                                     ),
//                                   );
//                             },
//                             trailing: const Icon(
//                               Icons.touch_app,
//                               color: Colors.grey,
//                               size: 16,
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//-------------------------------------------------------------------
import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_event.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
import 'package:ampify_admin_bloc/widgets/custom_app_bar.dart';
import 'package:ampify_admin_bloc/widgets/order_timeline.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/order_model/order_model.dart';
import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AdminOrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const AdminOrderDetailsScreen({super.key, required this.order});

  @override
  State<AdminOrderDetailsScreen> createState() =>
      _AdminOrderDetailsScreenState();
}

class _AdminOrderDetailsScreenState extends State<AdminOrderDetailsScreen> {
  late Stream<DocumentSnapshot> _orderStream;

  @override
  void initState() {
    super.initState();
    // Listen for real-time updates to the order document
    _orderStream = FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.order.id)
        .snapshots();
  }

  // Format the createdAt timestamp
  String formatDate(Timestamp timestamp) {
    final dateFormat = DateFormat('MMM dd, yyyy hh:mm a');
    return dateFormat.format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      appBar: const CustomAppBar(
        title: 'Order Details',
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return SingleChildScrollView(
            child: StreamBuilder<DocumentSnapshot>(
              stream: _orderStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text('Order not found'));
                }

                final orderData = snapshot.data!.data() as Map<String, dynamic>;
                final updatedOrder =
                    OrderModel.fromMap(widget.order.id, orderData);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Details
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: isMobile ? double.infinity : 600),
                        child: Card(
                          color: AppColors.backgroundColorLight,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order #${updatedOrder.id}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Ordered on: ${formatDate(updatedOrder.createdAt)}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Total: \₹${updatedOrder.totalAmount}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Delivery Address: ${updatedOrder.address}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Hint Text
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Tap on a status to update the order:",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: isMobile ? double.infinity : 600),
                        child: BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                OrderTimeline(
                                  status: "Pending",
                                  isFirst: true,
                                  isActive: updatedOrder.status == "Pending",
                                  icon: Icons.shopping_cart,
                                  description: "Your order has been placed.",
                                  animationPath:
                                      'assets/animations/order_placed.json',
                                  onTap: () {
                                    context.read<OrderBloc>().add(
                                          UpdateOrderStatus(
                                            orderId: updatedOrder.id,
                                            newStatus: "Pending",
                                          ),
                                        );
                                  },
                                  trailing: const Icon(
                                    Icons.touch_app,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ),
                                OrderTimeline(
                                  status: "Processing",
                                  isActive: updatedOrder.status == "Processing",
                                  icon: Icons.build,
                                  description: "Your order is being processed.",
                                  animationPath:
                                      'assets/animations/order_processing.json',
                                  onTap: () {
                                    context.read<OrderBloc>().add(
                                          UpdateOrderStatus(
                                            orderId: updatedOrder.id,
                                            newStatus: "Processing",
                                          ),
                                        );
                                  },
                                  trailing: const Icon(
                                    Icons.touch_app,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ),
                                OrderTimeline(
                                  status: "Shipped",
                                  isActive: updatedOrder.status == "Shipped",
                                  icon: Icons.local_shipping,
                                  description: "Your order has been shipped.",
                                  animationPath:
                                      'assets/animations/order_shipped.json',
                                  onTap: () {
                                    context.read<OrderBloc>().add(
                                          UpdateOrderStatus(
                                            orderId: updatedOrder.id,
                                            newStatus: "Shipped",
                                          ),
                                        );
                                  },
                                  trailing: const Icon(
                                    Icons.touch_app,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ),
                                OrderTimeline(
                                  status: "Delivered",
                                  isActive: updatedOrder.status == "Delivered",
                                  icon: Icons.check_circle,
                                  description: "Your order has been delivered.",
                                  animationPath:
                                      'assets/animations/order_delivered.json',
                                  onTap: () {
                                    context.read<OrderBloc>().add(
                                          UpdateOrderStatus(
                                            orderId: updatedOrder.id,
                                            newStatus: "Delivered",
                                          ),
                                        );
                                  },
                                  trailing: const Icon(
                                    Icons.touch_app,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
