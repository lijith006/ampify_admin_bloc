// import 'package:flutter/material.dart';
// import 'bar_chart_widget.dart'; // Ensure you import the BarChartWidget

// class RevenueChartSection extends StatefulWidget {
//   final Map<String, double> revenueData;

//   const RevenueChartSection({Key? key, required this.revenueData})
//       : super(key: key);

//   @override
//   _RevenueChartSectionState createState() => _RevenueChartSectionState();
// }

// class _RevenueChartSectionState extends State<RevenueChartSection> {
//   String _selectedTimeframe = 'weekly';

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Revenue Trend',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SegmentedButton<String>(
//                   segments: const [
//                     ButtonSegment(value: 'weekly', label: Text('Weekly')),
//                     ButtonSegment(value: 'monthly', label: Text('Monthly')),
//                     ButtonSegment(value: 'yearly', label: Text('Yearly')),
//                   ],
//                   selected: {_selectedTimeframe},
//                   onSelectionChanged: (Set<String> newSelection) {
//                     setState(() {
//                       _selectedTimeframe = newSelection.first;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Container(
//               height: 300,
//               child: widget.revenueData.isEmpty
//                   ? const Center(
//                       child: Text('No revenue data for selected timeframe'))
//                   : BarChartWidget(data: widget.revenueData),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
