import 'package:flutter_application_1/Features/Konfirmasi/Models/Pembayaran_Model.dart';

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
    image: "assets/images/BCA.jpg",
    category: PembayaranKategori.bank,
  ),
  PembayaranModel(
    id: "Mandiri",
    title: "Bank Mandiri",
    image: "assets/images/Mandiri.jpg",
    category: PembayaranKategori.bank,
  ),
  PembayaranModel(
    id: "BNI",
    title: "Bank Negara Indonesia",
    image: "assets/images/BNI.jpg",
    category: PembayaranKategori.bank,
  ),
  PembayaranModel(
    id: "BRI",
    title: "Bank Rakyat Indonesia",
    image: "assets/images/BRI.jpg",
    category: PembayaranKategori.bank,
  ),
  //Ewallet
  PembayaranModel(
    id: "Gopay",
    title: "Gopay",
    image: "assets/images/Gopay.jpg",
    category: PembayaranKategori.ewallet,
  ),
  PembayaranModel(
    id: "Dana",
    title: "Dana",
    image: "assets/images/Dana.jpg",
    category: PembayaranKategori.ewallet,
  ),
  PembayaranModel(
    id: "ShopeePay",
    title: "ShopeePay",
    image: "assets/images/Shopeepay.jpg",
    category: PembayaranKategori.ewallet,
  ),
  PembayaranModel(
    id: "OVO",
    title: "OVO",
    image: "assets/images/OVO.jpg",
    category: PembayaranKategori.ewallet,
  ),
  //card
  PembayaranModel(
    id: "Visa",
    title: "Visa",
    image: "",
    category: PembayaranKategori.kartu,
  ),
  PembayaranModel(
    id: "Mastercard",
    title: "Mastercard",
    image: "",
    category: PembayaranKategori.kartu,
  ),
  PembayaranModel(
    id: "JCB",
    title: "JCB",
    image: "",
    category: PembayaranKategori.kartu,
  ),
];
