import '../models/Riwayat_Model.dart';
import 'package:flutter/material.dart';

class RiwayatProvider with ChangeNotifier {
  final List<RiwayatModel> _riwayat = [];

  List<RiwayatModel> get riwayat => _riwayat;

  void tambahRiwayat(RiwayatModel data) {
    _riwayat.add(data);
    notifyListeners();
  }
}
