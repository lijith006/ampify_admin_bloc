// abstract class OrderEvent {}

// class FetchOrders extends OrderEvent {}

// class UpdateOrderStatus extends OrderEvent {
//   final String orderId;
//   final String newStatus;

//   UpdateOrderStatus({required this.orderId, required this.newStatus});
// }
//*************************************************** */
abstract class OrderEvent {}

class FetchOrders extends OrderEvent {}

class UpdateOrderStatus extends OrderEvent {
  final String orderId;
  final String newStatus;
  final String? location;

  UpdateOrderStatus(
      {required this.orderId, required this.newStatus, this.location});
}
