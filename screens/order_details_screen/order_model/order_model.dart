// import 'package:cloud_firestore/cloud_firestore.dart';

// class OrderModel {
//   final String id;
//   final String customerName;
//   final String orderId;
//   final String status;
//   final double totalAmount;
//   final Timestamp createdAt;
//   final String address;

//   OrderModel({
//     required this.id,
//     required this.customerName,
//     required this.orderId,
//     required this.status,
//     required this.totalAmount,
//     required this.createdAt,
//     required this.address,
//   });

//   // Static method to normalize status
//   static String normalizeStatus(String status) {
//     // Trim and convert to title case
//     status = status.trim();
//     if (status.isEmpty) return 'Pending';

//     return status[0].toUpperCase() + status.substring(1).toLowerCase();
//   }

//   factory OrderModel.fromMap(String docId, Map<String, dynamic> map) {
//     // Normalize status to first letter capitalized
//     String normalizedStatus = normalizeStatus(map['status'] ?? 'Pending');

//     return OrderModel(
//       id: docId,
//       customerName: map['customerName'] ?? 'Unknown Customer',
//       orderId: docId,
//       status: normalizedStatus,
//       totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
//       createdAt: map['createdAt'] ?? Timestamp.now(),
//       address: map['address'] ?? 'Unknown Address',
//     );
//   }
// }
//----------------------------------MArch 28

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String customerName;
  final String orderId;
  final String status;
  final double totalAmount;
  final DateTime orderDate;
  final Timestamp createdAt;
  final String address;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.orderId,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.createdAt,
    required this.address,
  });

  // Static method to normalize status
  static String normalizeStatus(String status) {
    // Trim and convert to title case
    status = status.trim();
    if (status.isEmpty) return 'Pending';

    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  factory OrderModel.fromMap(String docId, Map<String, dynamic> map) {
    // Normalize status to first letter capitalized
    String normalizedStatus = normalizeStatus(map['status'] ?? 'Pending');

    return OrderModel(
      id: docId,
      customerName: map['customerName'] ?? 'Unknown Customer',
      orderId: docId,
      status: normalizedStatus,
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
      orderDate: (map['orderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: map['createdAt'] ?? Timestamp.now(),
      address: map['address'] ?? 'Unknown Address',
    );
  }
}
