import 'package:flutter/material.dart';
import '../service/Local_Stage_service.dart';
import '../service/Auth_service.dart';

class AppStateProvider extends ChangeNotifier {
  bool? isWalkthrough;
  bool? isLoggeIn;

  final _local = LocalStorageService();
  final _auth = AuthService();

  Future<void> loadAppState() async {
    await Future.delayed( Duration(seconds: 3));
    isWalkthrough = await _local.isWalkthroughSeen();
    isLoggeIn = await _auth.isLoggedIn();
    notifyListeners();
  }
}
