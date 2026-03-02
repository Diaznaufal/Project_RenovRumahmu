class ProductModel {
  final String imageUrl;
  final String name;
  final int price;
  final int? oldPrice;
  final String? discount;
  final List<String> size;
  final bool isBestSeller;
  final bool isDiscount;

  ProductModel({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.oldPrice,
    this.discount,
    required this.size,
    required this.isBestSeller,
    required this.isDiscount,
  });
}
