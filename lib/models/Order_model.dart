import 'package:flutter_application_1/models/cart_item_model.dart';

class OrderModel {
  final String invoice;
  final List<CartItemModel> items;
  final int total;
  final DateTime orderTime;
  final String status;

  OrderModel({
    required this.invoice,
    required this.items,
    required this.total,
    required this.orderTime,
    this.status = "pending",
  });
}
