import 'package:flutter_application_1/models/product_cart.dart';

enum OrderType { material, bangunBaru, renovasi, perawatan }
enum OrderStatuss {
  menunggupembayaran,
  disiapkan,
  dikirim,
  selesai,
  dibatalkan,
}

class RiwayatModel {
  final String id;
  final OrderType type;
  final String serviceLabel;
  final String title;
  final DateTime date;
  final OrderStatuss status;
  final int? totalPrice; // material
  final int? progress; // project
  final List<CartItemModel>? items;

  RiwayatModel({
    required this.id,
    required this.type,
    required this.serviceLabel,
    required this.title,
    required this.date,
    required this.status,
    this.totalPrice,
    this.progress,
    this.items,
  });
}
