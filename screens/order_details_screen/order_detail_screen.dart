// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_event.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AdminOrderScreen extends StatefulWidget {
//   const AdminOrderScreen({super.key});

//   @override
//   State<AdminOrderScreen> createState() => _AdminOrderScreenState();
// }

// class _AdminOrderScreenState extends State<AdminOrderScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<OrderBloc>().add(FetchOrders());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin - Orders'),
//       ),
//       body: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
//         if (state is OrderLoading) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is OrdersLoaded) {
//           return ListView.builder(
//             itemCount: state.orders.length,
//             itemBuilder: (context, index) {
//               final order = state.orders[index];
//               return Card(
//                 margin: const EdgeInsets.all(8),
//                 child: ListTile(
//                   title: Text(order.productName),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Customer: ${order.customerName}"),
//                       Text("Total: \$${order.totalAmount.toStringAsFixed(2)}"),
//                       Text("Status: ${order.status}"),
//                     ],
//                   ),
//                   trailing: DropdownButton<String>(
//                       value: order.status,
//                       items: ['Pending', 'Processing', 'Shipped', 'Delivered']
//                           .map((status) => DropdownMenuItem(
//                               value: status, child: Text(status)))
//                           .toList(),
//                       onChanged: (newStatus) {
//                         if (newStatus != null) {
//                           context.read<OrderBloc>().add(
//                                 UpdateOrderStatus(
//                                     orderId: order.id, newStatus: newStatus),
//                               );
//                         }
//                       }),
//                 ),
//               );
//             },
//           );
//         } else if (state is OrderFailed) {
//           return Center(
//             child: Text('Error: ${state.error}'),
//           );
//         }
//         return const Center(child: Text("No orders found"));
//       }),
//     );
//   }
// }
//**************************************************** */
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_event.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// //class _AdminOrderScreenState extends State<AdminOrderScreen> {
// class AdminOrderScreen extends StatefulWidget {
//   const AdminOrderScreen({super.key});

//   @override
//   State<AdminOrderScreen> createState() => _AdminOrderScreenState();
// }

// class _AdminOrderScreenState extends State<AdminOrderScreen> {
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   context.read<OrderBloc>().add(FetchOrders());
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//                 return Card(
//                   margin: const EdgeInsets.all(8),
//                   child: ListTile(
//                     title: Text(order.productName),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Customer: ${order.customerName}"),
//                         Text(
//                             "Total: \$${order.totalAmount.toStringAsFixed(2)}"),
//                         Text("Status: ${order.status}"),
//                       ],
//                     ),
//                     trailing: DropdownButton<String>(
//                         value: order.status,
//                         items: ['pending', 'processing', 'shipped', 'delivered']
//                             .map((status) => DropdownMenuItem(
//                                 value: status,
//                                 child: Text(status[0].toUpperCase() +
//                                     status.substring(1))))
//                             .toList(),
//                         onChanged: (newStatus) {
//                           if (newStatus != null) {
//                             context.read<OrderBloc>().add(
//                                   UpdateOrderStatus(
//                                       orderId: order.id, newStatus: newStatus),
//                                 );
//                           }
//                         }),
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
//*****************************************frm cld */

import 'package:ampify_admin_bloc/common/app_colors.dart';
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
  // Define statuses with consistent capitalization
  final List<String> _validStatuses = [
    'Pending',
    'Processing',
    'Shipped',
    'Delivered'
  ];

  @override
  void initState() {
    super.initState();
    // Fetch orders when the screen initializes
    context.read<OrderBloc>().add(FetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      'Order id: ${order.id}',
                      style: const TextStyle(color: AppColors.orderColor),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Customer: ${order.customerName}"),
                        Text(
                            "Total: \₹${order.totalAmount.toStringAsFixed(2)}"),
                        Text("Status: ${order.status}",
                            style: const TextStyle(
                              color: AppColors.orderStatus,
                            )),
                      ],
                    ),
                    trailing: DropdownButton<String>(
                        value: order.status,
                        items: _validStatuses
                            .map((status) => DropdownMenuItem(
                                value: status, child: Text(status)))
                            .toList(),
                        onChanged: (newStatus) {
                          if (newStatus != null) {
                            context.read<OrderBloc>().add(
                                  UpdateOrderStatus(
                                      orderId: order.id, newStatus: newStatus),
                                );
                          }
                        }),
                  ),
                );
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
