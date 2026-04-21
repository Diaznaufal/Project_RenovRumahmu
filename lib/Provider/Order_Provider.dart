import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/Pembayaran_Model.dart';
import 'dart:async';
import 'dart:math';

class OrderProvider with ChangeNotifier {
  PembayaranModel? _selectedPayment;
  DateTime? _purchaseTime;
  DateTime? _expiryTime;
  Duration _remaining = Duration.zero;
  Timer? _timer;
  String? _invoice;
  DateTime? _orderTime;

  PembayaranModel? get selectedPayment => _selectedPayment;
  Duration get remainingTime => _remaining;
  DateTime? get expiryTime => _expiryTime;
  String? get invoice => _invoice;
  DateTime? get orderTime => _orderTime;

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

  void checkout(Map<String, CartItemModel> items) {
    if (items.isEmpty) {
      throw Exception("Cart kosong");
    }

    int total = 0;

    items.forEach((key, item) {
      total += item.totalPrice;
    });

    // generate order
    createOrder(total);

    // nanti di sini bisa:
    // 🔥 kirim ke API (POST /checkout)

    notifyListeners();
  }

  int? _total;

  int? get total => _total;

  void createOrder(int total) {
    final now = DateTime.now();

    final rand = Random().nextInt(99999);
    final number = rand.toString().padLeft(5, '0');

    _invoice = "SN-${now.year}${now.month}${now.day}-$number";

    _orderTime = now;
    _total = total;

    startPaymentCountdown();
  }
}
