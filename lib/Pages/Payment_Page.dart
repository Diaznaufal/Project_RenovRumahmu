import 'package:flutter/material.dart';
import '../models/Riwayat_Model.dart';

class PaymentPage extends StatelessWidget {
  final RiwayatModel order;

  PaymentPage({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pembayaran")),
      body: Center(child: Text("Order ID: ${order.id}")),
    );
  }
}
