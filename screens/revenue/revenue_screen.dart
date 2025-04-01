// // import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// // import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:fl_chart/fl_chart.dart';

// // class RevenueScreen extends StatelessWidget {
// //   const RevenueScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Revenue Overview')),
// //       body: BlocBuilder<OrderBloc, OrderState>(
// //         builder: (context, state) {
// //           if (state is OrderLoading) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (state is OrdersLoaded) {
// //             if (state.revenueData.isEmpty) {
// //               return const Center(child: Text("No revenue data available."));
// //             }

// //             return Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Text("📊 Revenue Chart",
// //                       style:
// //                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //                   const SizedBox(height: 10),
// //                   SizedBox(
// //                     height: 300,
// //                     child: LineChart(
// //                       LineChartData(
// //                         gridData: FlGridData(show: false),
// //                         titlesData: FlTitlesData(
// //                           leftTitles: AxisTitles(
// //                               sideTitles: SideTitles(showTitles: true)),
// //                           bottomTitles: AxisTitles(
// //                             sideTitles: SideTitles(
// //                               showTitles: true,
// //                               getTitlesWidget: (value, meta) {
// //                                 int index = value.toInt();
// //                                 List<String> dates =
// //                                     state.revenueData.keys.toList();
// //                                 if (index < dates.length) {
// //                                   return Text(dates[index],
// //                                       style: const TextStyle(fontSize: 10));
// //                                 }
// //                                 return const Text('');
// //                               },
// //                             ),
// //                           ),
// //                         ),
// //                         borderData: FlBorderData(show: true),
// //                         lineBarsData: [
// //                           LineChartBarData(
// //                             spots: state.revenueData.entries
// //                                 .map((e) => FlSpot(
// //                                     state.revenueData.keys
// //                                         .toList()
// //                                         .indexOf(e.key)
// //                                         .toDouble(),
// //                                     e.value))
// //                                 .toList(),
// //                             isCurved: true,
// //                             barWidth: 3,
// //                             color: Colors.blue,
// //                             belowBarData: BarAreaData(
// //                                 show: true,
// //                                 color: Colors.blue.withOpacity(0.3)),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           } else if (state is OrderFailed) {
// //             return Center(child: Text("Error: ${state.error}"));
// //           }
// //           return const Center(child: Text("No data available."));
// //         },
// //       ),
// //     );
// //   }
// // }
// //------------------------------------------------------------
// // import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// // import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
// // import 'package:ampify_admin_bloc/screens/revenue/revenue_model.dart';
// // import 'package:ampify_admin_bloc/screens/revenue/revenue_widget/revenue_line_chart.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:intl/intl.dart';

// // class RevenueScreen extends StatefulWidget {
// //   @override
// //   _RevenueScreenState createState() => _RevenueScreenState();
// // }

// // class _RevenueScreenState extends State<RevenueScreen> {
// //   String selectedView = "Daily"; // Default selection

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Revenue Overview")),
// //       body: BlocBuilder<OrderBloc, OrderState>(
// //         builder: (context, state) {
// //           if (state is OrderLoading) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (state is OrdersLoaded) {
// //             if (state.revenueData.isEmpty) {
// //               return Center(child: Text("No revenue data available."));
// //             }

// //             // Convert List to Revenue Model
// //             List<Revenue> revenueList = state.revenueData.entries.map((e) {
// //               return Revenue(date: DateTime.parse(e.key), amount: e.value);
// //             }).toList();

// //             // Get Grouped Data
// //             Map<String, double> groupedData = selectedView == "Daily"
// //                 ? groupRevenueByDay(revenueList)
// //                 : groupRevenueByMonth(revenueList);

// //             return Padding(
// //               padding: EdgeInsets.all(16.0),
// //               child: Column(
// //                 children: [
// //                   // Toggle Between Daily & Monthly
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text("View: "),
// //                       DropdownButton<String>(
// //                         value: selectedView,
// //                         onChanged: (newValue) {
// //                           setState(() {
// //                             selectedView = newValue!;
// //                           });
// //                         },
// //                         items: ["Daily", "Monthly"]
// //                             .map((view) => DropdownMenuItem(
// //                                   value: view,
// //                                   child: Text(view),
// //                                 ))
// //                             .toList(),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 20),

// //                   // Line Chart for Revenue Trends
// //                   SizedBox(height: 300, child: RevenueChart(data: groupedData)),

// //                   const SizedBox(height: 20),

// //                   // Total Revenue Display
// //                   Text(
// //                     "Total Revenue: \$${groupedData.values.fold(0.0, (sum, e) => sum + e).toStringAsFixed(2)}",
// //                     style: const TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.green),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           }
// //           return const Center(child: Text("No data available."));
// //         },
// //       ),
// //     );
// //   }

// //   Map<String, double> groupRevenueByDay(List<Revenue> revenueList) {
// //     Map<String, double> dailyRevenue = {};

// //     for (var revenue in revenueList) {
// //       String day = DateFormat('yyyy-MM-dd').format(revenue.date);
// //       dailyRevenue.update(day, (value) => value + revenue.amount,
// //           ifAbsent: () => revenue.amount);
// //     }

// //     return dailyRevenue;
// //   }

// //   Map<String, double> groupRevenueByMonth(List<Revenue> revenueList) {
// //     Map<String, double> monthlyRevenue = {};

// //     for (var revenue in revenueList) {
// //       String month = DateFormat('yyyy-MM').format(revenue.date);
// //       monthlyRevenue.update(month, (value) => value + revenue.amount,
// //           ifAbsent: () => revenue.amount);
// //     }

// //     return monthlyRevenue;
// //   }
// // }
// //**************************************************** */
// // import 'package:fl_chart/fl_chart.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// // import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';

// // class RevenueScreen extends StatefulWidget {
// //   @override
// //   _RevenueScreenState createState() => _RevenueScreenState();
// // }

// // class _RevenueScreenState extends State<RevenueScreen> {
// //   String _selectedView = 'daily';

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Revenue Analytics'),
// //       ),
// //       body: BlocBuilder<OrderBloc, OrderState>(
// //         builder: (context, state) {
// //           if (state is OrdersLoaded) {
// //             // Just check if revenue data is empty
// //             if (state.revenueData.isEmpty) {
// //               return const Center(
// //                 child: Text('No revenue data available'),
// //               );
// //             }

// //             // Process the data based on selected view
// //             Map<String, double> processedData = _selectedView == 'daily'
// //                 ? state.revenueData
// //                 : _aggregateDataByMonth(state.revenueData);

// //             return Column(
// //               children: [
// //                 // Toggle buttons for daily/monthly view
// //                 Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       ToggleButtons(
// //                         isSelected: [
// //                           _selectedView == 'daily',
// //                           _selectedView == 'monthly'
// //                         ],
// //                         onPressed: (index) {
// //                           setState(() {
// //                             _selectedView = index == 0 ? 'daily' : 'monthly';
// //                           });
// //                         },
// //                         children: const [
// //                           Padding(
// //                             padding: EdgeInsets.symmetric(horizontal: 16.0),
// //                             child: Text('Daily'),
// //                           ),
// //                           Padding(
// //                             padding: EdgeInsets.symmetric(horizontal: 16.0),
// //                             child: Text('Monthly'),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 // Revenue summary
// //                 Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Card(
// //                     elevation: 4,
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(16.0),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           const Text(
// //                             'Total Revenue:',
// //                             style: TextStyle(
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                           Text(
// //                             '₹${_calculateTotalRevenue(state.revenueData).toStringAsFixed(2)}',
// //                             style: const TextStyle(
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.green,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),

// //                 // Chart
// //                 Expanded(
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(16.0),
// //                     child: RevenueChart(data: processedData),
// //                   ),
// //                 ),
// //               ],
// //             );
// //           } else if (state is OrderLoading) {
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           } else if (state is OrderFailed) {
// //             return Center(
// //               child: Text('Error: ${state.error}'),
// //             );
// //           }
// //           return const Center(
// //             child: Text('No data available'),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   // Helper method to aggregate daily data into monthly data
// //   Map<String, double> _aggregateDataByMonth(Map<String, double> dailyData) {
// //     Map<String, double> monthlyData = {};

// //     for (var entry in dailyData.entries) {
// //       // Extract year and month from the date (format YYYY-MM-DD)
// //       String yearMonth = entry.key.substring(0, 7); // Gets YYYY-MM

// //       // Add revenue to the monthly total
// //       monthlyData[yearMonth] = (monthlyData[yearMonth] ?? 0) + entry.value;
// //     }

// //     return monthlyData;
// //   }

// //   // Calculate total revenue
// //   double _calculateTotalRevenue(Map<String, double> data) {
// //     return data.values.fold(0, (prev, amount) => prev + amount);
// //   }
// // }

// // class RevenueChart extends StatelessWidget {
// //   final Map<String, double> data;

// //   RevenueChart({required this.data});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Sort keys to ensure chronological order
// //     List<String> sortedKeys = data.keys.toList()..sort();

// //     // Create spots for the chart
// //     List<FlSpot> spots = [];
// //     for (int i = 0; i < sortedKeys.length; i++) {
// //       double value = data[sortedKeys[i]] ?? 0;
// //       spots.add(FlSpot(i.toDouble(), value));
// //     }

// //     return Column(
// //       children: [
// //         // Title
// //         const Text(
// //           'Revenue Trend',
// //           style: TextStyle(
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         const SizedBox(height: 20),

// //         // Chart
// //         Expanded(
// //           child: LineChart(
// //             LineChartData(
// //               gridData: FlGridData(
// //                 show: true,
// //                 drawVerticalLine: true,
// //                 drawHorizontalLine: true,
// //               ),
// //               titlesData: FlTitlesData(
// //                 bottomTitles: AxisTitles(
// //                   sideTitles: SideTitles(
// //                     showTitles: true,
// //                     getTitlesWidget: (value, meta) {
// //                       if (value >= 0 && value < sortedKeys.length) {
// //                         // For dates, show shortened format
// //                         String label = sortedKeys[value.toInt()];
// //                         if (label.length > 5) {
// //                           // If it's YYYY-MM-DD format, show MM-DD
// //                           label = label.length > 7
// //                               ? label.substring(5)
// //                               : label.substring(0);
// //                         }
// //                         return Padding(
// //                           padding: const EdgeInsets.only(top: 5),
// //                           child: Text(
// //                             label,
// //                             style: const TextStyle(
// //                               fontSize: 10,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                         );
// //                       }
// //                       return const SizedBox();
// //                     },
// //                     reservedSize: 30,
// //                   ),
// //                 ),
// //                 leftTitles: AxisTitles(
// //                   sideTitles: SideTitles(
// //                     showTitles: true,
// //                     getTitlesWidget: (value, meta) {
// //                       return Padding(
// //                         padding: const EdgeInsets.only(right: 5),
// //                         child: Text(
// //                           '₹${value.toInt()}',
// //                           style: const TextStyle(fontSize: 10),
// //                         ),
// //                       );
// //                     },
// //                     reservedSize: 50,
// //                   ),
// //                 ),
// //                 topTitles: const AxisTitles(
// //                   sideTitles: SideTitles(showTitles: false),
// //                 ),
// //                 rightTitles: const AxisTitles(
// //                   sideTitles: SideTitles(showTitles: false),
// //                 ),
// //               ),
// //               borderData: FlBorderData(
// //                 show: true,
// //                 border: Border.all(color: Colors.grey.shade300),
// //               ),
// //               minX: -0.5,
// //               maxX: sortedKeys.length - 0.5,
// //               minY: 0,
// //               lineBarsData: [
// //                 LineChartBarData(
// //                   spots: spots,
// //                   isCurved: true,
// //                   color: Colors.blue,
// //                   barWidth: 3,
// //                   isStrokeCapRound: true,
// //                   dotData: const FlDotData(
// //                     show: true,
// //                   ),
// //                   belowBarData: BarAreaData(
// //                     show: true,
// //                     color: Colors.blue.withOpacity(0.2),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //*************************cloud
// // */
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_bloc.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
// import 'package:ampify_admin_bloc/screens/order_details_screen/order_model/order_model.dart';
// import 'package:intl/intl.dart';

// class SalesAnalyticsScreen extends StatefulWidget {
//   @override
//   _SalesAnalyticsScreenState createState() => _SalesAnalyticsScreenState();
// }

// class _SalesAnalyticsScreenState extends State<SalesAnalyticsScreen> {
//   String _selectedTimeframe = 'monthly'; // 'weekly', 'monthly', 'yearly'

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sales Analytics'),
//         elevation: 1,
//       ),
//       body: BlocBuilder<OrderBloc, OrderState>(
//         builder: (context, state) {
//           if (state is OrderLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is OrdersLoaded) {
//             if (state.orders.isEmpty) {
//               return const Center(
//                 child: Text('No order data available'),
//               );
//             }

//             // Process the delivered orders for analytics
//             List<OrderModel> completedOrders = state.orders
//                 .where((order) => order.status == "Delivered")
//                 .toList();

//             if (completedOrders.isEmpty) {
//               return const Center(
//                 child: Text('No completed orders to analyze'),
//               );
//             }

//             // Extract product information
//             Map<String, int> productCounts = _getProductCounts(completedOrders);
//             List<MapEntry<String, int>> topProducts =
//                 _getTopProducts(productCounts, 5);
//             int totalProductsSold = _getTotalProductsSold(productCounts);
//             double totalRevenue = _calculateTotalRevenue(completedOrders);

//             // Prepare data for selected timeframe
//             Map<String, double> revenueData =
//                 _getRevenueData(completedOrders, _selectedTimeframe);

//             return SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Top summary cards
//                     _buildSummaryCards(totalRevenue, completedOrders.length,
//                         totalProductsSold),

//                     const SizedBox(height: 24),

//                     // Revenue chart section
//                     _buildRevenueChartSection(revenueData),

//                     const SizedBox(height: 24),

//                     // Top products section
//                     _buildTopProductsSection(topProducts),
//                   ],
//                 ),
//               ),
//             );
//           } else if (state is OrderFailed) {
//             return Center(
//               child: Text('Error: ${state.error}'),
//             );
//           }
//           return const Center(
//             child: Text('No data available'),
//           );
//         },
//       ),
//     );
//   }
//   //************************************** */
//   Map<String, int> _getProductCounts(List<OrderModel> orders) {
//     // Placeholder implementation - replace with actual logic based on your data model
//     Map<String, int> productCounts = {
//       'Amplifier XR-150': 43,
//       'Pro Audio Speaker 12"': 38,
//       'Wireless Headphones AMP-1': 32,
//       'DJ Controller S2': 27,
//       'MIDI Keyboard 49K': 25,
//       'Studio Monitors (Pair)': 22,
//       'Bass Guitar 5-String': 18,
//     };
//     return productCounts;
//   }
  
//   List<MapEntry<String, int>> _getTopProducts(Map<String, int> productCounts, int limit) {
//     var sortedEntries = productCounts.entries.toList()
//       ..sort((a, b) => b.value.compareTo(a.value));
//     return sortedEntries.take(limit).toList();
//   }
  
//   int _getTotalProductsSold(Map<String, int> productCounts) {
//     return productCounts.values.fold(0, (sum, count) => sum + count);
//   }
  
//   double _calculateTotalRevenue(List<OrderModel> orders) {
//     return orders.fold(0, (sum, order) => sum + order.totalAmount);
//   }
  
//   Map<String, double> _getRevenueData(List<OrderModel> orders, String timeframe) {
//     Map<String, double> revenueData = {};
    
//     for (var order in orders) {
//       String key;
//       DateTime date = order.orderDate;
      
//       switch (timeframe) {
//         case 'weekly':
//           // Group by week - use the Sunday of each week as key
//           int daysToSubtract = date.weekday % 7;
//           DateTime weekStart = date.subtract(Duration(days: daysToSubtract));
//           key = DateFormat('MMM d').format(weekStart);
//           break;
//         case 'monthly':
//           // Group by month
//           key = DateFormat('MMM yyyy').format(date);
//           break;
//         case 'yearly':
//           // Group by year
//           key = DateFormat('yyyy').format(date);
//           break;
//         default:
//           key = DateFormat('yyyy-MM-dd').format(date);
//       }
      
//       revenueData[key] = (revenueData[key] ?? 0) + order.totalAmount;
//     }
    
//     return revenueData;
//   }
// }

