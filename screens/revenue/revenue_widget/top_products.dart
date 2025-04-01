// import 'package:flutter/material.dart';

// class TopProductsSection extends StatelessWidget {
//   final List<MapEntry<String, int>> topProducts;

//   const TopProductsSection({Key? key, required this.topProducts})
//       : super(key: key);

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
//             const Text(
//               'Top 5 Ordered Products',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             topProducts.isEmpty
//                 ? const Center(child: Text('No product data available'))
//                 : ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: topProducts.length,
//                     separatorBuilder: (context, index) => const Divider(),
//                     itemBuilder: (context, index) {
//                       final product = topProducts[index];
//                       return ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.blue.withOpacity(0.2),
//                           child: Text('${index + 1}'),
//                         ),
//                         title: Text(product.key),
//                         trailing: Text(
//                           '${product.value} units',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
