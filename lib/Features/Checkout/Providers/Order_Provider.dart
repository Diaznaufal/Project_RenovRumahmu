import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Checkout/Models/Order_model.dart';
import 'package:flutter_application_1/Features/Renovasi/Models/Renovasi_Model.dart';
import '../../Keranjang/Models/cart_item_model.dart';
import '../../Konfirmasi/Models/Pembayaran_Model.dart';
import 'dart:async';
import 'dart:math';

class OrderProvider with ChangeNotifier {
  PembayaranModel? _selectedPayment;

  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  DateTime? _purchaseTime;

  DateTime? _expiryTime;

  Duration _remaining = Duration.zero;

  Timer? _timer;

  String? _invoice;

  DateTime? _orderTime;

  int? _total;

  PembayaranModel? get selectedPayment => _selectedPayment;

  Duration get remainingTime => _remaining;

  DateTime? get expiryTime => _expiryTime;

  String? get invoice => _invoice;

  DateTime? get orderTime => _orderTime;

  int? get total => _total;

  String? _paymentType;

  String? get paymentType => _paymentType;

  // ================= PAYMENT =================

  void selectPayment(PembayaranModel? payment) {
    _selectedPayment = payment;
    notifyListeners();
  }

  // ================= COUNTDOWN =================

  void startPaymentCountdown() {
    _purchaseTime = DateTime.now();

    _expiryTime = _purchaseTime!.add(Duration(hours: 24));

    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final now = DateTime.now();

      final diff = _expiryTime!.difference(now);

      if (diff.isNegative) {
        _remaining = Duration.zero;

        _timer?.cancel();
      } else {
        _remaining = diff;
      }

      notifyListeners();
    });
  }

  // ================= CHECKOUT =================

  void checkout({
    required Map<String, CartItemModel> items,
    required int total,
  }) {
    if (items.isEmpty) {
      throw Exception("Cart kosong");
    }

    createOrder(total);

    notifyListeners();
  }

  // ================= RENOVASI =================

  void checkoutRenovasi({required RenovasiModel data, required int total}) {
    final now = DateTime.now();

    final rand = Random().nextInt(99999);

    final number = rand.toString().padLeft(5, '0');

    final invoice = "RNV-${now.year}${now.month}${now.day}-$number";

    final order = OrderModel(
      invoice: invoice,
      total: total,
      orderTime: now,
      type: "renovasi",
    );

    _orders.add(order);

    createOrder(total);

    notifyListeners();
  }

  // ================= CREATE ORDER =================

  void createOrder(int total) {
    final now = DateTime.now();

    final rand = Random().nextInt(99999);

    final number = rand.toString().padLeft(5, '0');

    _invoice = "SN-${now.year}${now.month}${now.day}-$number";

    _orderTime = now;

    _total = total;

    startPaymentCountdown();

    notifyListeners();
  }

  // ================= PAYMENT TYPE =================

  void setPaymentType(String? value) {
    _paymentType = value;

    notifyListeners();
  }

  bool get isDp {
    return _paymentType == "dp";
  }

  bool get isFull {
    return _paymentType == "full";
  }

  // ================= TOTAL =================

  int get bayarSekarang {
    if (_total == null) return 0;

    if (isDp) {
      return (_total! * 0.3).round();
    }

    return _total!;
  }

  int get sisaPembayaran {
    if (_total == null) return 0;

    if (isFull) {
      return 0;
    }

    return _total! - bayarSekarang;
  }

  // ================= RESET =================

  void resetPayment() {
    _selectedPayment = null;

    _paymentType = null;

    _total = null;

    notifyListeners();
  }
}
