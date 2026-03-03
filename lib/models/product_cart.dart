import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  final String selectedSize;
  int quantity;
  bool isSelected;

  CartItemModel({
    required this.product,
    required this.selectedSize,
    required this.quantity,
    this.isSelected = false,
  });

  int get totalPrice {
    return product.price * quantity;
  }

  CartItemModel copy() {
    return CartItemModel(
      product: product,
      selectedSize: selectedSize,
      quantity: quantity,
      isSelected: isSelected,
    );
  }
}
