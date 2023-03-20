import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_or_register.dart';

/*

AUTH PAGE

This is the AuthPage, it handles user authentication; 

If a user is logged in it takes them to the Home Page else it takes them to the Login Page

*/

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // Always watching for Auth State Changes
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // USER is logged in
            return HomePage();
          } else {
            // USER is not logged in
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
