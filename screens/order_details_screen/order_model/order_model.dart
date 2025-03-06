// class OrderModel {
//   final String id;
//   final String customerName;
//   final String productName;
//   final String status;
//   final double totalAmount;

//   OrderModel(
//       {required this.id,
//       required this.customerName,
//       required this.productName,
//       required this.status,
//       required this.totalAmount});

//   factory OrderModel.fromMap(Map<String, dynamic> map) {
//     return OrderModel(
//       id: map['id'],
//       customerName: map['customerName'],
//       productName: map['productName'],
//       status: map['status'],
//       totalAmount: (map['totalAmount'] as num).toDouble(),
//     );
//   }
// }
//************************************ */

// class OrderModel {
//   final String id;
//   final String customerName;
//   final String productName;
//   final String status;
//   final double totalAmount;

//   OrderModel(
//       {required this.id,
//       required this.customerName,
//       required this.productName,
//       required this.status,
//       required this.totalAmount});

//   factory OrderModel.fromMap(Map<String, dynamic> map) {
//     return OrderModel(
//       id: map['id'] ?? '',
//       customerName: map['customerName'] ?? 'Unknown Customer',
//       productName: map['productName'] ?? 'Unknown Product',
//       status: map['status'] ?? 'Pending',
//       totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
//     );
//   }
// }
// class OrderModel {
//   final String id;
//   final String customerName;
//   final String productName;
//   final String status;
//   final double totalAmount;

//   OrderModel(
//       {required this.id,
//       required this.customerName,
//       required this.productName,
//       required this.status,
//       required this.totalAmount});

//   factory OrderModel.fromMap(String docId, Map<String, dynamic> map) {
//     return OrderModel(
//       id: docId, // Use the document ID from Firestore
//       customerName: map['customerName'] ?? 'Unknown Customer',
//       productName: map['productName'] ?? 'Unknown Product',
//       status: (map['status'] as String?)?.toLowerCase() ??
//           'pending', // Ensure lowercase
//       totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
//     );
//   }
// }
//*******************************************************************************************
// */

// class OrderModel {
//   final String id;
//   final String customerName;
//   final String productName;
//   final String status;
//   final double totalAmount;

//   OrderModel(
//       {required this.id,
//       required this.customerName,
//       required this.productName,
//       required this.status,
//       required this.totalAmount});

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
//       customerName: map['users'] ?? 'Unknown Customer',
//       productName: map['title'] ?? 'Unknown Product',
//       status: normalizedStatus,
//       totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
//     );
//   }
// }
//9999999999999999999999999999999999999999
class OrderModel {
  final String id;
  final String customerName;
  final String orderId;
  final String status;
  final double totalAmount;

  OrderModel(
      {required this.id,
      required this.customerName,
      required this.orderId,
      required this.status,
      required this.totalAmount});

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
      // orderId: map['title'] ?? 'Unknown Product',
      status: normalizedStatus,
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
