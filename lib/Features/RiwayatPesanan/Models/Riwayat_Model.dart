import '../../Konfirmasi/Models/Pembayaran_Model.dart';
import 'package:flutter_application_1/Features/Keranjang/Models/cart_item_model.dart';

enum OrderType { material, bangunBaru, renovasi, perawatan }

enum OrderStatuss {
  menunggupembayaran,
  disiapkan,
  dikirim,
  selesai,
  dibatalkan,
}

enum RenovasiStatus { menunggupembayaran, survey, berjalan, selesai }

enum RenovasiStep {
  pembayaranBelumSelesai,

  membuatJadwal,
  surveyDijadwalkan,

  pengerjaanberlangsung,
  finishing,

  proyekSelesai,
}

class RiwayatModel {
  final String id;
  final OrderType type;
  final String serviceLabel;
  final String title;
  final List<String>? imagePath;
  final DateTime date;
  final PembayaranModel? paymenMethod;
  final OrderStatuss? orderStatuss;
  final RenovasiStatus? renovasiStatus;
  final RenovasiStep? renovasiStep;
  final int? totalPrice; // material
  final double? progress; // project
  final String? tahap;
  final List<CartItemModel>? items;

  //renovasi
  final String? area;
  final String? kebutuhan;
  final String? tingkatKerusakan;
  final DateTime? tanggalKunjungan;
  final String? jamKunjungan;
  final String? pengerjaan;
  final List<String>? media;
  final String? deskripsi;
  final String? metodePembayaranProyek;
  final int? bayarSekarang;
  final int? sisaPembayaran;
  final int? biayaJasa;
  final int? biayaMaterial;
  final int? biayaPenyesuaian;
  final String? promoCode;
  final int? diskonPromo;

  RiwayatModel({
    required this.id,
    required this.type,
    required this.serviceLabel,
    required this.title,
    this.imagePath,
    required this.date,
    this.paymenMethod,
    this.orderStatuss,
    this.renovasiStatus,
    this.renovasiStep,
    this.totalPrice,
    this.progress,
    this.tahap,
    this.items,
    this.biayaJasa,
    this.biayaMaterial,
    this.biayaPenyesuaian,
    this.promoCode,
    this.diskonPromo,

    //renovasi
    this.area,
    this.kebutuhan,
    this.tingkatKerusakan,
    this.tanggalKunjungan,
    this.jamKunjungan,
    this.pengerjaan,
    this.media,
    this.deskripsi,
    this.metodePembayaranProyek,
    this.bayarSekarang,
    this.sisaPembayaran,
  });
}
