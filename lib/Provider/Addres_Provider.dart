import 'package:flutter/material.dart';
import '../models/Addres_model.dart';

class AddressProvider with ChangeNotifier {
  final List<AddressModel> _addresses = [];

  AddressModel? _selectedAddress;

  List<AddressModel> get addresses => [..._addresses];

  AddressModel? get selectedAddress => _selectedAddress;

  void addAddress(AddressModel address) {
    _addresses.add(address);

    _selectedAddress ??= address;

    notifyListeners();
  }

  void selectAddress(AddressModel address) {
    _selectedAddress = address;
    notifyListeners();
  }

  void updateAddress(String id, AddressModel newAddress) {
    final index = _addresses.indexWhere((e) => e.id == id);
    if (index != -1) {
      _addresses[index] = newAddress;
      notifyListeners();
    }
  }

  void removeAddress(String id) {
    _addresses.removeWhere((addr) => addr.id == id);

    if (_selectedAddress?.id == id) {
      _selectedAddress = _addresses.isNotEmpty ? _addresses.first : null;
    }

    notifyListeners();
  }
}
