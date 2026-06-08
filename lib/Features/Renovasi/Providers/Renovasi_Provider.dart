import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Remote/Promo_Renovasi.dart';
import 'package:flutter_application_1/Data/Remote/Renovasi_Form/Kebutuhan_Options.dart';
import 'package:flutter_application_1/Data/Remote/Renovasi_Form/Pekerjaan_Options.dart';
import 'package:flutter_application_1/Features/Checkout/Providers/Order_Provider.dart';
import 'package:flutter_application_1/Features/Renovasi/Models/Promo_Model.dart';
import 'package:flutter_application_1/Features/Renovasi/Models/Renovasi_Model.dart';
import 'package:flutter_application_1/Features/RiwayatPesanan/Models/Riwayat_Model.dart';

class RenovasiProvider with ChangeNotifier {
  RenovasiModel formData = RenovasiModel();
  RiwayatModel? currentOrder;
  PromoModel? _appliedPromo;
  PromoModel? get appliedPromo => _appliedPromo;

  int currentStep = 0;
  int _discountAmount = 0;
  int get discountAmount => _discountAmount;

  // STEP CONTROL

  void nextStep() {
    if (isStepValid(currentStep)) {
      currentStep++;
      notifyListeners();
    }
  }

  void setCurrentOrder(RiwayatModel order) {
    currentOrder = order;
    notifyListeners();
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  void setStep(int step) {
    currentStep = step;
    notifyListeners();
  }

  bool applyPromo(String code) {
    try {
      final promo = promoRenov.firstWhere(
        (item) => item.code.toLowerCase() == code.toLowerCase(),
      );

      _appliedPromo = promo;

      _discountAmount = ((estimasiHarga * promo.discountValue) / 100).round();

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }

  // STEP 1

  void setKebutuhan(String value) {
    formData.kebutuhan = value;
    notifyListeners();
  }

  void setArea(String value) {
    formData.area = value;
    notifyListeners();
  }

  void setTingkat(String value) {
    formData.tingkatKerusakan = value;
    notifyListeners();
  }

  // STEP 2

  void setAlamat(String value) {
    formData.alamat = value;
    notifyListeners();
  }

  void setCatatanLokasi(String value) {
    formData.catatanLokasi = value;
    notifyListeners();
  }

  void setMedia(List<String> files) {
    formData.media = files;
    notifyListeners();
  }

  void setDeskripsi(String value) {
    formData.deskripsi = value;
    notifyListeners();
  }

  // STEP 3

  void setTanggal(DateTime value) {
    formData.tanggalKunjungan = value;
    notifyListeners();
  }

  void setCatatan(String value) {
    formData.catatan = value;
    notifyListeners();
  }

  void setJam(String value) {
    formData.jamKunjungan = value;
    notifyListeners();
  }

  void setPengerjaan(String value) {
    formData.pengerjaan = value;
    notifyListeners();
  }
  // STEP 5

  // VALIDASI PER STEP

  bool isStepValid(int step) {
    switch (step) {
      case 0:
        return formData.kebutuhan != null &&
            formData.area != null &&
            formData.tingkatKerusakan != null;

      case 1:
        return formData.alamat != null &&
            formData.alamat!.isNotEmpty &&
            formData.media != null &&
            formData.media!.isNotEmpty &&
            formData.deskripsi != null &&
            formData.deskripsi!.isNotEmpty;
      case 2:
        return formData.tanggalKunjungan != null &&
            formData.jamKunjungan != null &&
            formData.pengerjaan != null;
      default:
        return true;
    }
  }

  bool isMetodePembayaranValid(OrderProvider order) {
    return order.paymentType != null && order.selectedPayment != null;
  }

  // ======================
  // FINAL VALIDATION (CHECKOUT)
  // ======================
  bool get isAllValid {
    return formData.kebutuhan != null &&
        formData.area != null &&
        formData.tingkatKerusakan != null &&
        formData.alamat != null &&
        formData.tanggalKunjungan != null &&
        formData.jamKunjungan != null &&
        formData.pengerjaan != null &&
        formData.deskripsi != null;
  }

  int get diskonPromo {
    if (_appliedPromo == null) return 0;

    final subtotal = biayaJasa + biayaMaterial;

    return ((subtotal * _appliedPromo!.discountValue) / 100).round();
  }

  int get biayaMaterial {
    if (isBorongan) {
      return 50000;
    }
    if (formData.pengerjaan == "harian") {
      return 100000;
    }

    return 0;
  }

  int get biayaJasa {
    // jika harian
    if (formData.pengerjaan == "harian") {
      return 500000;
    }

    int total = 0;

    final kebutuhan = kebutuhanOptions.firstWhere(
      (item) => item.value == formData.kebutuhan,
    );

    final pekerjaan = pekerjaanOptions.firstWhere(
      (item) => item.value == formData.tingkatKerusakan,
    );

    total += kebutuhan.price;
    total += pekerjaan.price;

    return total;
  }

  int get estimasiHarga {
    final subtotal = biayaJasa + biayaMaterial;

    if (_appliedPromo == null) {
      return subtotal;
    }

    final diskon = ((subtotal * _appliedPromo!.discountValue) / 100).round();

    return subtotal - diskon;
  }

  bool get isBorongan {
    return formData.pengerjaan == "borongan";
  }

  bool isPembayaranValid(OrderProvider order) {
    return order.paymentType != null && order.selectedPayment != null;
  }

  // ======================
  // RESET (kalau selesai / ulang)
  // ======================
  void reset() {
    final savedAlamat = formData.alamat;
    formData = RenovasiModel();
    formData.alamat = savedAlamat;
    currentStep = 0;
    _appliedPromo = null;
    _discountAmount = 0;
    notifyListeners();
  }

  void removeMedia(String path) {
    formData.media = formData.media?.where((item) => item != path).toList();
    notifyListeners();
  }
}
