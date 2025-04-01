// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class RevenueChart extends StatelessWidget {
//   final Map<String, double> revenueData;

//   RevenueChart({required this.revenueData});

//   @override
//   Widget build(BuildContext context) {
//     List<FlSpot> revenueSpots = [];
//     List<String> dates = revenueData.keys.toList();

//     for (int i = 0; i < dates.length; i++) {
//       revenueSpots.add(FlSpot(i.toDouble(), revenueData[dates[i]]!));
//     }

//     return SizedBox(
//       height: 300,
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: false),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   int index = value.toInt();
//                   if (index < dates.length) {
//                     return Text(dates[index], style: TextStyle(fontSize: 10));
//                   }
//                   return Text('');
//                 },
//               ),
//             ),
//           ),
//           borderData: FlBorderData(show: true),
//           lineBarsData: [
//             LineChartBarData(
//               spots: revenueSpots,
//               isCurved: true,
//               barWidth: 3,
//               color: Colors.blue,
//               belowBarData:
//                   BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//---------------------------MARCH 28
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class RevenueChart extends StatelessWidget {
//   final Map<String, double> revenueData;

//   RevenueChart({required this.revenueData});

//   @override
//   Widget build(BuildContext context) {
//     List<FlSpot> revenueSpots = [];
//     List<String> dates = revenueData.keys.toList();

//     for (int i = 0; i < dates.length; i++) {
//       revenueSpots.add(FlSpot(i.toDouble(), revenueData[dates[i]]!));
//     }

//     return SizedBox(
//       height: 300,
//       child: LineChart(
//         LineChartData(
//           gridData: const FlGridData(
//               show: true, drawVerticalLine: false, horizontalInterval: 5000),
//           titlesData: FlTitlesData(
//             leftTitles:
//                 const AxisTitles(sideTitles: SideTitles(showTitles: true)),
//             bottomTitles: AxisTitles(
//               axisNameWidget: const Text("Revenue"),
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 interval: 5000,
//                 getTitlesWidget: (value, meta) =>
//                     Text(formatLargeNumbers(value)),
//               ),
//             ),
//           ),
//           borderData: FlBorderData(show: true),
//           lineBarsData: [
//             LineChartBarData(
//               spots: revenueSpots,
//               isCurved: true,
//               barWidth: 3,
//               color: Colors.blue,
//               belowBarData:
//                   BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String formatLargeNumbers(double value) {
//     if (value >= 1000) {
//       return '${(value / 1000).toStringAsFixed(1)}K';
//     }
//     return value.toString();
//   }
// }
