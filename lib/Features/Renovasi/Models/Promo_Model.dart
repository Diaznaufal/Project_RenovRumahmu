enum DiscounType { percentage, nominal }

class PromoModel {
  final String code;
  final String title;
  final String desc;
  final DiscounType discountType;
  final double discountValue;
  final double minimunPurchase;
  final double maximumDiscount;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;

  const PromoModel({
    required this.code,
    required this.title,
    required this.desc,
    required this.discountType,
    required this.discountValue,
    required this.minimunPurchase,
    required this.maximumDiscount,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });
}
