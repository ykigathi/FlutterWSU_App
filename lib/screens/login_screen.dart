import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsuapp/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final String email = emailController.text.trim();
                final String password = passwordController.text.trim();
                final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);

                try {
                  await authProvider.login(email, password);
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (error) {
                  print('Login failed: $error');
                  // Handle login failure (e.g., show error message)
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
