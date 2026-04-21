import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// ================= INIT DATA (DUMMY) =================
  Future<void> loadDummyProducts() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1)); // simulasi loading

    _products = [
      ProductModel(
        imageUrl: "assets/images/baju1.png",
        name: "Kaos Polos Hitam",
        price: 75000,
        oldPrice: 100000,
        discount: "25%",
        size: ["S", "M", "L", "XL"],
        isBestSeller: true,
        isDiscount: true,
        category: "Kaos",
      ),
      ProductModel(
        imageUrl: "assets/images/baju2.png",
        name: "Hoodie Abu",
        price: 150000,
        oldPrice: null,
        discount: null,
        size: ["M", "L", "XL"],
        isBestSeller: false,
        isDiscount: false,
        category: "Hoodie",
      ),
      ProductModel(
        imageUrl: "assets/images/celana1.png",
        name: "Celana Jeans Biru",
        price: 200000,
        oldPrice: 250000,
        discount: "20%",
        size: ["28", "30", "32", "34"],
        isBestSeller: true,
        isDiscount: true,
        category: "Celana",
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  /// ================= GET BY CATEGORY =================
  List<ProductModel> getByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  /// ================= GET BEST SELLER =================
  List<ProductModel> get bestSeller {
    return _products.where((p) => p.isBestSeller).toList();
  }

  /// ================= GET DISCOUNT =================
  List<ProductModel> get discountProducts {
    return _products.where((p) => p.isDiscount).toList();
  }

  /// ================= FIND BY NAME =================
  ProductModel? findByName(String name) {
    try {
      return _products.firstWhere((p) => p.name == name);
    } catch (e) {
      return null;
    }
  }

  /// ================= FUTURE API READY =================
  /// Nanti tinggal ganti isi function ini
  Future<void> fetchFromApi() async {
    _isLoading = true;
    notifyListeners();

    try {
      // nanti isi:
      // final response = await http.get(...)
      // _products = ...
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
