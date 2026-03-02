import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/Local_Stage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthProvider extends ChangeNotifier {
  bool isLogin = false;
  bool isInitialized = false;

  String name = "";
  String email = "";

  // Login Status

  final LocalStorageService storage = LocalStorageService();

  Future<void> loadAuth() async {
    final prefs = await SharedPreferences.getInstance();
    isLogin = await storage.isLoggedIn();
    name = prefs.getString('username') ?? "";
    email = prefs.getString('email') ?? "";
    isInitialized = true;
    notifyListeners();
  }

  // Register

  Future<String?> register({
    required String nameInput,
    required String emailInput,
    required String passwordInput,
    required String confirmPassInput,
  }) async {
    if (nameInput.isEmpty ||
        emailInput.isEmpty ||
        passwordInput.isEmpty ||
        confirmPassInput.isEmpty) {
      return "Semua field wajib diisi";
    }

    if (passwordInput.length < 6) {
      return "Password minimal 6 karakter";
    }

    if (passwordInput != confirmPassInput) {
      return "Password tidak sama";
    }

    name = nameInput;
    email = emailInput;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setString('email', email);

    return null;
  }

  // Login

  Future<String?> login(String input, String inputPassword) async {
    if (input.isEmpty || inputPassword.isEmpty) {
      return "Username / Email dan Password wajib diisi";
    }

    final isValidUser = input == name || input == email;

    if (!isValidUser) {
      return "Username atau Email tidak terdaftar";
    }

    isLogin = true;
    await storage.setLoggedIn(true);

    notifyListeners();
    return null;
  }

  Future<void> logout() async {
    isLogin = false;
    await storage.setLoggedIn(false);
    notifyListeners();
  }
}
