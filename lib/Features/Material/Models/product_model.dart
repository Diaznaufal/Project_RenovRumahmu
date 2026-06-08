class ProductModel {
  final String imageUrl;
  final String name;
  final int price;
  final int? discount;
  final List<String> size;
  final bool isBestSeller;
  final bool isDiscount;
  final String category;

  ProductModel({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.discount,
    required this.size,
    required this.isBestSeller,
    required this.isDiscount,
    required this.category,
  });
  int get finalPrice {
    if (discount == null) {
      return price;
    }

    return price - ((price * discount!) ~/ 100);
  }
}
