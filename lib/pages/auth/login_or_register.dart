import 'package:ajourn_app/pages/auth/login_page.dart';
import 'package:ajourn_app/pages/auth/register_page.dart';

import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show login
  bool isLogInPage = true;

  //toggle between pages
  void togglePage() {
    setState(() {
      isLogInPage = !isLogInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogInPage) {
      return LoginPage(onTap: togglePage);
    } else {
      return RegisterPage(onTap: togglePage);
    }
  }
}
