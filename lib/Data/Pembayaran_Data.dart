import 'package:flutter_application_1/models/Pembayaran_Model.dart';

final List<PembayaranKategoriModel> PembayaranKategorii = [
  PembayaranKategoriModel(
    type: PembayaranKategori.bank,
    title: "Transfer Bank (VA)",
    iconPath: "assets/icon/Bank.svg",
  ),
  PembayaranKategoriModel(
    type: PembayaranKategori.ewallet,
    title: "E-Wallet",
    iconPath: "assets/icon/E-Wallet.svg",
  ),
  PembayaranKategoriModel(
    type: PembayaranKategori.kartu,
    title: "Kartu Kredit/Debit",
    iconPath: "assets/icon/Kartu.svg",
  ),
];

final List<PembayaranModel> MetodePembayaran = [
  //Bank
  PembayaranModel(
    id: "BCA",
    title: "Bank Central Asia",
    category: PembayaranKategori.bank,
  ),
  PembayaranModel(
    id: "Mandiri",
    title: "Bank Mandiri",
    category: PembayaranKategori.bank,
  ),
  PembayaranModel(
    id: "BNI",
    title: "Bank Negara Indonesia",
    category: PembayaranKategori.bank,
  ),
  PembayaranModel(
    id: "BRI",
    title: "Bank Rakyat Indonesia",
    category: PembayaranKategori.bank,
  ),
  //Ewallet
  PembayaranModel(
    id: "Gopay",
    title: "Gopay",
    category: PembayaranKategori.ewallet,
  ),
  PembayaranModel(
    id: "Dana",
    title: "Dana",
    category: PembayaranKategori.ewallet,
  ),
  PembayaranModel(
    id: "ShopeePay",
    title: "ShopeePay",
    category: PembayaranKategori.ewallet,
  ),
  PembayaranModel(
    id: "OVO",
    title: "OVO",
    category: PembayaranKategori.ewallet,
  ),
  //card
  PembayaranModel(
    id: "Visa",
    title: "Visa",
    category: PembayaranKategori.kartu,
  ),
  PembayaranModel(
    id: "Mastercard",
    title: "Mastercard",
    category: PembayaranKategori.kartu,
  ),
  PembayaranModel(id: "JCB", title: "JCB", category: PembayaranKategori.kartu),
];
