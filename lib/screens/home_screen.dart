import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsuapp/providers/auth_provider.dart';
import 'package:wsuapp/providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (authProvider.isAuthenticated)
              Column(
                children: [
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: 'Last Name'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final String firstName = firstNameController.text.trim();
                      final String lastName = lastNameController.text.trim();

                      try {
                        await userProvider.createUser(firstName, lastName, authProvider.token!);
                        await userProvider.fetchUsers(authProvider.token!);
                      } catch (error) {
                        print('Failed to create user: $error');
                      }
                    },
                    child: Text('Create User'),
                  ),
                ],
              ),
            if (userProvider.users.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text('Users:'),
                  for (final user in userProvider.users)
                    Text('${user.firstName} ${user.lastName}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
