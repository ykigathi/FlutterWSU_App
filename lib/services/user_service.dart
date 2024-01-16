import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:wsuapp/models/user_model.dart';

class UserService {
  static const String apiUrl = 'http://localhost:3000/api';

  Future<void> createUser(String firstName, String lastName, String token) async {
    final response = await http.post(
      Uri.parse('$apiUrl/users'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'firstName': firstName, 'lastName': lastName}),
    );

    if (response.statusCode == 201) {
      print('User created successfully');
    } else {
      print('Failed to create user: ${response.statusCode}');
    }
  }
}
