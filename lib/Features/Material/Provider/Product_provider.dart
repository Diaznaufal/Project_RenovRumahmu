import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Remote/Product_material.dart';
import '../Models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _error;

  /// ================= GETTER =================
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// ================= LOAD DATA =================
  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _products = productList;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// ================= SET EXTERNAL DATA (🔥 INI KUNCINYA) =================
  void setProducts(List<ProductModel> newProducts) {
    _products = newProducts;
    notifyListeners();
  }

  /// ================= RESET KE SEMUA DATA =================
  void resetProducts() {
    _products = productList;
    notifyListeners();
  }

  /// ================= REFRESH =================
  Future<void> refreshProducts() async {
    await loadProducts();
  }

  /// ================= FILTER CATEGORY =================
  List<ProductModel> getByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  /// ================= BEST SELLER =================
  List<ProductModel> get bestSeller {
    return _products.where((p) => p.isBestSeller).toList();
  }

  /// ================= DISCOUNT =================
  List<ProductModel> get discountProducts {
    return _products.where((p) => p.isDiscount).toList();
  }

  /// ================= SEARCH =================
  List<ProductModel> search(String keyword) {
    return _products
        .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  /// ================= FIND DETAIL =================
  ProductModel? findByName(String name) {
    try {
      return _products.firstWhere((p) => p.name == name);
    } catch (_) {
      return null;
    }
  }

  /// ================= FUTURE API READY =================
  Future<void> fetchFromApi() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _products = productList;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
