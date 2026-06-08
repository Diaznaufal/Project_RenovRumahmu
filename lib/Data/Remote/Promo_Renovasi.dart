import 'package:flutter_application_1/Features/Renovasi/Models/Promo_Model.dart';

final List<PromoModel> promoRenov = [
  PromoModel(
    code: "RENOVBARU",
    title: "Promo Renovasi Baru",
    desc: "Diskon 10% untuk renovasi",
    discountType: DiscounType.percentage,
    discountValue: 10,
    minimunPurchase: 1000000,
    maximumDiscount: 250000,
    startDate: DateTime(2026, 1, 1),
    endDate: DateTime(2026, 6, 20),
    isActive: true,
  ),

  PromoModel(
    code: "ORDERPERTAMA",
    title: "Promo Pelanggan Baru",
    desc: "Diskon 5% untuk renovasi",
    discountType: DiscounType.percentage,
    discountValue: 5,
    minimunPurchase: 750000,
    maximumDiscount: 100000,
    startDate: DateTime(2026, 1, 15),
    endDate: DateTime(2026, 12, 20),
    isActive: true,
  ),
];
