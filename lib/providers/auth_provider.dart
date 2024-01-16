import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wsuapp/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService = AuthService();
  String? _token;

  String? get token => _token;

  Future<void> login(String email, String password) async {
    try {
      _token = await authService.login(email, password);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
  }

  bool get isAuthenticated => _token != null;

  Future<bool> autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      // You might want to check if the token is still valid here
      // and perform any necessary validation or refresh
      _token = token;
      notifyListeners();
      return true;
    }

    return false;
  }

  // Add the update method
  void update() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      // You might want to check if the token is still valid here
      // and perform any necessary validation or refresh
      _token = token;
      notifyListeners();
    }
  }
}
