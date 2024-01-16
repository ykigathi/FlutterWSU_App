import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wsuapp/providers/auth_provider.dart';
import 'package:wsuapp/providers/user_provider.dart';
import 'package:wsuapp/screens/home_screen.dart';
import 'package:wsuapp/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (_) => UserProvider(),
          update: (_, auth, user) => user!..update(auth),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthCheck(),
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return FutureBuilder(
      future: authProvider.autoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading indicator or splash screen
          return CircularProgressIndicator();
        } else {
          return Navigator(
            pages: [
              if (snapshot.data == true) MaterialPage(child: HomeScreen()),
              if (snapshot.data != true) MaterialPage(child: LoginScreen()),
            ],
            onPopPage: (route, result) => route.didPop(result),
          );
        }
      },
    );
  }
}
