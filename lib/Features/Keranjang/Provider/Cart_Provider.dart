import 'package:flutter/material.dart';
import '../../Material/Models/product_model.dart';
import '../Models/cart_item_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItemModel> _items = {};
  final Map<String, String> _selectedSizes = {};

  Map<String, CartItemModel> get items => {..._items};

  int _shippingCost = 0;

  int get shippingCost => _shippingCost;

  int get totalAmount {
    return _items.values.fold(0, (total, item) => total + item.totalPrice);
  }

  int get totalPembayaran {
    return totalSelectedAmount + shippingCost;
  }

  int get totalSelectedAmount {
    return _items.values
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.totalPrice);
  }

  String? getSelectedSize(String productName) {
    return _selectedSizes[productName];
  }

  void setSelectedSize(String productName, String size) {
    _selectedSizes[productName] = size;
    notifyListeners();
  }

  int get selectedItemCount {
    return _items.values.where((item) => item.isSelected).length;
  }

  void toggleSelectAll(bool value) {
    for (var item in _items.values) {
      item.isSelected = value;
    }
    notifyListeners();
  }

  int get totalDiscount {
    return _items.values.fold(0, (total, item) {
      final product = item.product;

      if (product.discount != null) {
        final discount = (product.price * product.discount!) ~/ 100;

        return total + (discount * item.quantity);
      }

      return total;
    });
  }

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

  void toggleItemSelection(String key, bool value) {
    if (!_items.containsKey(key)) return;

    _items[key]!.isSelected = value;
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

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void selectShipping(int cost) {
    _shippingCost = cost;
    notifyListeners();
  }
}
