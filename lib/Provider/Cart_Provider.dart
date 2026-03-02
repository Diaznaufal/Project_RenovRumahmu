import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/product_cart.dart';
import '../models/Pembayaran_Model.dart';
import 'dart:async';

class CartProvider with ChangeNotifier {
  final Map<String, CartItemModel> _items = {};
  final Map<String, String> _selectedSizes = {};

  Map<String, CartItemModel> get items => {..._items};

  int _shippingCost = 0;
  PembayaranModel? _selectedPayment;
  PembayaranModel? get selectedPayment => _selectedPayment;
  DateTime? _purchaseTime;
  DateTime? _expiryTime;
  Duration _remaining = Duration.zero;
  Timer? _timer;

  DateTime? get expiryTime => _expiryTime;
  Duration get remainingTime => _remaining;
  int get shippingCost => _shippingCost;
  int get totalAmount {
    return items.values.fold(0, (total, item) => total + item.totalPrice);
  }

  int get totalSelectedAmount {
    return _items.values
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get selectedItemCount {
    return _items.values.where((item) => item.isSelected).length;
  }

  int get totalDiscount {
    return _items.values.where((item) => item.isSelected).fold(0, (sum, item) {
      if (item.product.oldPrice != null) {
        int discountPerItem = (item.product.oldPrice! - item.product.price);
        return sum + (discountPerItem * item.quantity);
      }
      return sum;
    });
  }

  int get subtotalSelected => _items.values
      .where((item) => item.isSelected)
      .fold(
        0,
        (sum, item) =>
            sum +
            ((item.product.oldPrice ?? item.product.price) * item.quantity),
      );

  int get totalPayment => totalSelectedAmount + shippingCost;

  void addToCart({
    required ProductModel product,
    required String selectedSize,
    int quantity = 1,
  }) {
    final key = '${product.name}_$selectedSize';

    if (_items.containsKey(key)) {
      _items[key]!.quantity += quantity;
    } else {
      _items[key] = CartItemModel(
        product: product,
        selectedSize: selectedSize,
        quantity: quantity,
      );
    }

    notifyListeners();
  }

  void increaseQuantity(String key) {
    if (_items.containsKey(key)) {
      _items[key]!.quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(String key) {
    if (!_items.containsKey(key)) return;

    if (_items[key]!.quantity > 1) {
      _items[key]!.quantity--;
    } else {
      _items.remove(key);
    }

    notifyListeners();
  }

  void removeItem(String key) {
    _items.remove(key);
    notifyListeners();
  }

  void increaseQty(CartItemModel item) {
    item.quantity++;
    notifyListeners();
  }

  void selectShipping(int cost) {
    _shippingCost = cost;
    notifyListeners();
  }

  void setSelectedSize(String productId, String size) {
    _selectedSizes[productId] = size;
    notifyListeners();
  }

  String? getSelectedSize(String productName) {
    return _selectedSizes[productName];
  }

  void decreaseQty(CartItemModel item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      final key = '${item.product.name}_${item.selectedSize}';
      _items.remove(key);
    }
    notifyListeners();
  }

  void toggleItemSelection(CartItemModel item, bool value) {
    item.isSelected = value;
    notifyListeners();
  }

  void toggleSelectAll(bool value) {
    for (var item in _items.values) {
      item.isSelected = value;
    }
    notifyListeners();
  }

  void updateQty(CartItemModel item, int newQty) {
    if (newQty < 1) return;

    item.quantity = newQty;
    notifyListeners();
  }

  void removeCartItem(CartItemModel item) {
    final key = '${item.product.name}_${item.selectedSize}';
    _items.remove(key);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void selectPayment(PembayaranModel? payment) {
    _selectedPayment = payment;
    notifyListeners();
  }

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
}
