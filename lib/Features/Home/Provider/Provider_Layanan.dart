import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/StatusPesanan/Renovasi/Models/Status_Proyek.dart';
import '../../../Core/service/Proyek_Layanan.dart';

class ProviderLayanan with ChangeNotifier {
  List<StatusProyek> _proyekList = [];
  bool _isLoading = false;

  List<StatusProyek> get proyekList => _proyekList;
  bool get isLoading => _isLoading;

  Future<void> fetchProyek() async {
    _isLoading = true;
    notifyListeners();

    _proyekList = await ProyekLayanan.getProyek();

    _isLoading = false;
    notifyListeners();
  }
}
