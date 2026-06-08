import 'package:flutter/material.dart';
import '../Models/Addres_model.dart';

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

  bool get hasSelectedAddress {
    return _selectedAddress != null;
  }

  void updateAddress(AddressModel updatedAddress) {
    final index = _addresses.indexWhere((e) => e.id == updatedAddress.id);

    if (index != -1) {
      _addresses[index] = updatedAddress;

      // penting
      if (_selectedAddress?.id == updatedAddress.id) {
        _selectedAddress = updatedAddress;
      }

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
