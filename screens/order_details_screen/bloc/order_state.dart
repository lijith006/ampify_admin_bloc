import 'package:ampify_admin_bloc/screens/order_details_screen/order_model/order_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<OrderModel> orders;

  OrdersLoaded({required this.orders});
}

class OrderStatusUpdated extends OrderState {
  final String orderId;
  final String newStatus;
  OrderStatusUpdated({required this.orderId, required this.newStatus});
}

class OrderFailed extends OrderState {
  final String error;

  OrderFailed({required this.error});
}
