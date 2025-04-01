// import 'package:ampify_admin_bloc/screens/revenue/revenue_widget/induvidual_summary_card.dart';
// import 'package:flutter/material.dart';

// class SummaryCardsGrid extends StatelessWidget {
//   final double totalRevenue;
//   final int totalOrders;
//   final int totalProductsSold;

//   const SummaryCardsGrid({
//     Key? key,
//     required this.totalRevenue,
//     required this.totalOrders,
//     required this.totalProductsSold,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       crossAxisCount: 3,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       children: [
//         SummaryCard(
//           title: 'Total Revenue',
//           value: '₹${totalRevenue.toStringAsFixed(2)}',
//           icon: Icons.monetization_on_outlined,
//           color: Colors.green.shade400,
//         ),
//         SummaryCard(
//           title: 'Total Orders',
//           value: totalOrders.toString(),
//           icon: Icons.shopping_bag_outlined,
//           color: Colors.blue.shade400,
//         ),
//         SummaryCard(
//           title: 'Products Sold',
//           value: totalProductsSold.toString(),
//           icon: Icons.inventory_2_outlined,
//           color: Colors.orange.shade400,
//         ),
//       ],
//     );
//   }
// }
