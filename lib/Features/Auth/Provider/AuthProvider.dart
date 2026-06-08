import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/service/Local_Stage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool isLogin = false;
  bool isInitialized = false;

  String name = "";
  String email = "";

  final LocalStorageService storage = LocalStorageService();

  // LOAD AUTH

  Future<void> loadAuth() async {
    final prefs = await SharedPreferences.getInstance();

    isLogin = await storage.isLoggedIn();

    name = prefs.getString('username') ?? "";
    email = prefs.getString('email') ?? "";

    isInitialized = true;

    notifyListeners();
  }

  // REGISTER

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

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', nameInput);
    await prefs.setString('email', emailInput);
    await prefs.setString('password', passwordInput);

    name = nameInput;
    email = emailInput;

    notifyListeners();

    return null;
  }

  // LOGIN

  Future<String?> login(String input, String inputPassword) async {
    if (input.isEmpty || inputPassword.isEmpty) {
      return "Username / Email dan Password wajib diisi";
    }

    final prefs = await SharedPreferences.getInstance();

    final savedUsername = prefs.getString('username') ?? "";
    final savedEmail = prefs.getString('email') ?? "";
    final savedPassword = prefs.getString('password') ?? "";

    final isValidUser = input == savedUsername || input == savedEmail;

    final isValidPassword = inputPassword == savedPassword;

    if (!isValidUser) {
      return "Username atau Email tidak terdaftar";
    }

    if (!isValidPassword) {
      return "Password salah";
    }

    isLogin = true;

    await storage.setLoggedIn(true);

    notifyListeners();

    return null;
  }

  // LOGOUT

  Future<void> logout() async {
    isLogin = false;

    await storage.setLoggedIn(false);

    notifyListeners();
  }
}
