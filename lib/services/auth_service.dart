import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static const String apiUrl = 'http://192.168.137.50:3000/api';
  // static const String apiUrl = 'http://localhost:3000/api';

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/authRoutes/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String token = responseData['token'];
      await saveToken(token);
      return token;
    } else {
      throw Exception('Failed to log in: ${response.statusCode}');
    }
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      // You might want to check if the token is still valid here
      // and perform any necessary validation or refresh
      return true;
    }

    return false;
  }
}
