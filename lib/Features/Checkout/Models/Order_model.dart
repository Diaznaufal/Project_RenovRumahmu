import 'package:flutter_application_1/Features/Renovasi/Models/Renovasi_Model.dart';
import 'package:flutter_application_1/Features/Keranjang/Models/cart_item_model.dart';

class OrderModel {
  final String invoice;
  final List<CartItemModel>? items;
  final int total;
  final DateTime orderTime;
  final String status;
  final String type;
  final RenovasiModel? renovasi;

  OrderModel({
    required this.invoice,
    this.items,
    required this.total,
    required this.orderTime,
    this.status = "pending",
    this.renovasi,
    required this.type,
  });
}
