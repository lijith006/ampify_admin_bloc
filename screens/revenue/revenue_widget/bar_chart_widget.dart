// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class BarChartWidget extends StatelessWidget {
//   final Map<String, double> data;

//   BarChartWidget({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     // Sort keys chronologically
//     List<String> sortedKeys = data.keys.toList();

//     // Create bar groups
//     List<BarChartGroupData> barGroups = [];
//     for (int i = 0; i < sortedKeys.length; i++) {
//       barGroups.add(
//         BarChartGroupData(
//           x: i,
//           barRods: [
//             BarChartRodData(
//               toY: data[sortedKeys[i]] ?? 0,
//               color: Colors.blue,
//               width: 20,
//               borderRadius: BorderRadius.circular(4),
//               backDrawRodData: BackgroundBarChartRodData(
//                 show: true,
//                 toY: _getMaxValue(data) * 1.1,
//                 color: Colors.grey.withOpacity(0.1),
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.spaceAround,
//         maxY: _getMaxValue(data) * 1.1,
//         titlesData: FlTitlesData(
//           show: true,
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 if (value >= 0 && value < sortedKeys.length) {
//                   // Format the label to fit
//                   String label = sortedKeys[value.toInt()];
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Text(
//                       label,
//                       style: const TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   );
//                 }
//                 return const SizedBox();
//               },
//               reservedSize: 32,
//             ),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: Text(
//                     '₹${value.toInt()}',
//                     style: const TextStyle(fontSize: 10),
//                   ),
//                 );
//               },
//               reservedSize: 40,
//             ),
//           ),
//           topTitles: const AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           rightTitles: const AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//         ),
//         gridData: FlGridData(
//           show: true,
//           drawVerticalLine: false,
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: Colors.grey.withOpacity(0.2),
//               strokeWidth: 1,
//             );
//           },
//         ),
//         borderData: FlBorderData(show: false),
//         barGroups: barGroups,
//       ),
//     );
//   }

//   double _getMaxValue(Map<String, double> data) {
//     if (data.isEmpty) return 1000;
//     return data.values.reduce((max, value) => max > value ? max : value);
//   }
// }
