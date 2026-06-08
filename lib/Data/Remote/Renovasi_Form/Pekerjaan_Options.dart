import '../../../Features/Renovasi/Models/Renovasi_OpsiPilih.dart';

final List<RenovasiOpsipilih> pekerjaanOptions = [
  RenovasiOpsipilih(
    value: "ringan",
    title: "Ringan",
    desc: "Pekerjaan skala kecil dengan perubahan terbatas",
    price: 100000,
  ),
  RenovasiOpsipilih(
    value: "sedang",
    title: "Sedang",
    desc: "Pekerjaan skala menengah",
    price: 300000,
  ),
  RenovasiOpsipilih(
    value: "berat",
    title: "Berat",
    desc: "Pekerjaan skala besara atau pembongkaran",
    price: 550000,
  ),
];
