// import 'package:ampify_admin_bloc/common/app_colors.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/order_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_event.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';

// class AdminOrderScreen extends StatefulWidget {
//   const AdminOrderScreen({super.key});

//   @override
//   State<AdminOrderScreen> createState() => _AdminOrderScreenState();
// }

// class _AdminOrderScreenState extends State<AdminOrderScreen> {
//   final List<String> _validStatuses = [
//     'Pending',
//     'Processing',
//     'Shipped',
//     'Delivered'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Fetch orders when the screen initializes
//     context.read<OrderBloc>().add(FetchOrders());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColorLight,
//       appBar: AppBar(
//         title: const Text('Admin - Orders'),
//       ),
//       body: BlocBuilder<OrderBloc, OrderState>(
//         builder: (context, state) {
//           if (state is OrderLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is OrdersLoaded) {
//             return ListView.builder(
//               itemCount: state.orders.length,
//               itemBuilder: (context, index) {
//                 final order = state.orders[index];

//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               AdminOrderDetailsScreen(order: order),
//                         ));
//                   },
//                   child: Card(
//                     color: AppColors.backgroundColorLight,
//                     elevation: 0,
//                     margin: const EdgeInsets.all(8),
//                     child: ListTile(
//                       title: Text(
//                         'Order id: ${order.id}',
//                         style: const TextStyle(color: AppColors.orderColor),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Customer: ${order.customerName}"),
//                           Text(
//                               "Total: \₹${order.totalAmount.toStringAsFixed(2)}"),
//                           Text("Status: ${order.status}",
//                               style: const TextStyle(
//                                 color: AppColors.orderStatus,
//                               )),
//                         ],
//                       ),
//                       trailing: DropdownButton<String>(
//                           value: order.status,
//                           items: _validStatuses
//                               .map((status) => DropdownMenuItem(
//                                   value: status, child: Text(status)))
//                               .toList(),
//                           onChanged: (newStatus) {
//                             if (newStatus != null) {
//                               context.read<OrderBloc>().add(
//                                     UpdateOrderStatus(
//                                         orderId: order.id,
//                                         newStatus: newStatus),
//                                   );
//                             }
//                           }),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is OrderFailed) {
//             return Center(
//               child: Text('Error: ${state.error}'),
//             );
//           }
//           return const Center(child: Text("No orders found"));
//         },
//       ),
//     );
//   }
// }
//************************************************************************************** */
import 'package:ampify_admin_bloc/common/app_colors.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/order_details_screen.dart';
import 'package:ampify_admin_bloc/utils/order_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_event.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when the screen initializes
    context.read<OrderBloc>().add(FetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      appBar: AppBar(
        title: const Text('Admin - Orders'),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrdersLoaded) {
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];

                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AdminOrderDetailsScreen(order: order),
                          ));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdminOrderDetailsScreen(order: order),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Order ID and Status
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order #${order.id}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: OrderUtils.getStatusColor(
                                              order.status)
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      order.status,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: OrderUtils.getStatusColor(
                                            order.status),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Customer Name
                              Text(
                                "Customer: ${order.customerName}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Total Amount
                              Text(
                                "Total: \₹${order.totalAmount.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            );
          } else if (state is OrderFailed) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          }
          return const Center(child: Text("No orders found"));
        },
      ),
    );
  }
}
