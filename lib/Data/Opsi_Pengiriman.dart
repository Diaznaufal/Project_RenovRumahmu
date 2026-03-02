import '../models/Pengiriman_Model.dart';

final List<PengirimanModel> OpsiPengiriman = [
  PengirimanModel(
    code: "REG",
    title: "REGULER",
    cost: 30000,
    minDay: 2,
    maxDay: 4,
  ),
  PengirimanModel(
    code: "SMD",
    title: "SAME DAY",
    cost: 50000,
    minDay: 0,
    maxDay: 1,
  ),
];
