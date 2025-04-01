import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_event.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/bloc/order_state.dart';
import 'package:ampify_admin_bloc/screens/order_details_screen/order_model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OrderBloc() : super(OrderInitial()) {
    // on<FetchOrders>(_onFetchOrders);
    on<FetchOrders>(_onFetchOrders);

    on<UpdateOrderStatus>(_onUpdateOrderStatus);
  }

  // Fetch all orders for Admin
  // Future<void> _onFetchOrders(
  //     FetchOrders event, Emitter<OrderState> emit) async {
  //   emit(OrderLoading());
  //   try {
  //     QuerySnapshot snapshot = await _firestore.collection('orders').get();

  //     List<OrderModel> orders = snapshot.docs.map((doc) {
  //       // Pass both document ID and data to fromMap
  //       return OrderModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  //     }).toList();

  //     emit(OrdersLoaded(orders: orders));
  //   } catch (e) {
  //     emit(OrderFailed(error: e.toString()));
  //   }
  // }
  Future<void> _onFetchOrders(
      FetchOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      QuerySnapshot snapshot = await _firestore.collection('orders').get();

      List<OrderModel> orders = snapshot.docs.map((doc) {
        // Pass both document ID and data to fromMap
        return OrderModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
      List<OrderModel> completedOrders =
          orders.where((o) => o.status == "Delivered").toList();
      // Group revenue by date
      Map<String, double> revenueByDate = {};
      for (var order in completedOrders) {
        String date = order.orderDate
            .toString()
            .split(" ")[0]; // Extract date only (YYYY-MM-DD)
        revenueByDate[date] = (revenueByDate[date] ?? 0) + order.totalAmount;
      }
      emit(OrdersLoaded(orders: orders, revenueData: revenueByDate));
    } catch (e) {
      emit(OrderFailed(error: e.toString()));
    }
  }

  Future<void> _onUpdateOrderStatus(
      UpdateOrderStatus event, Emitter<OrderState> emit) async {
    try {
      // Normalize the status before updating
      String normalizedStatus = OrderModel.normalizeStatus(event.newStatus);

      await _firestore.collection('orders').doc(event.orderId).update({
        'status': normalizedStatus,
        'updatedAt': FieldValue.serverTimestamp(),
        'location': event.location ?? "Processing Center",
      });

      emit(OrderStatusUpdated(
          orderId: event.orderId, newStatus: normalizedStatus));

      // Fetch updated orders to reflect changes
      add(FetchOrders());
    } catch (e) {
      emit(OrderFailed(error: e.toString()));
    }
  }
}
