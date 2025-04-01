// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class RevenueChart extends StatelessWidget {
//   final Map<String, double> data;
//   RevenueChart({required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         gridData: FlGridData(show: false),
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 List<String> keys = data.keys.toList();
//                 if (value.toInt() >= 0 && value.toInt() < keys.length) {
//                   return Text(keys[value.toInt()],
//                       style: TextStyle(fontSize: 10));
//                 }
//                 return const Text(
//                     ""); // Return an empty Text widget for out-of-range values
//               },
//             ),
//           ),
//         ),
//         borderData: FlBorderData(show: true),
//         lineBarsData: [
//           LineChartBarData(
//             spots: data.entries
//                 .map((e) => FlSpot(
//                     data.keys.toList().indexOf(e.key).toDouble(), e.value))
//                 .toList(),
//             isCurved: true,
//             barWidth: 3,
//             color: Colors.blue,
//             dotData: const FlDotData(show: false),
//           ),
//         ],
//       ),
//     );
//   }
// }
