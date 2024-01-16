import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsuapp/models/user_model.dart';
import 'package:wsuapp/providers/auth_provider.dart';
import 'package:wsuapp/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService userService = UserService();
  List<User> _users = [];

  List<User> get users => _users;

  Future<void> createUser(String firstName, String lastName, String token) async {
    try {
      await userService.createUser(firstName, lastName, token);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchUsers(String token) async {
    // Implement fetching users from the API and update _users list
    // ...
    notifyListeners();
  }

  // Add the update method
  void update(AuthProvider authProvider) async {
    if (authProvider.isAuthenticated) {
      await fetchUsers(authProvider.token!);
    }
  }
}
