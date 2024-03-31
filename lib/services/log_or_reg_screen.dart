// ignore_for_file: prefer_const_constructors

import 'package:chat_app/pages/login_screen.dart';
import 'package:chat_app/pages/register_screen.dart';
import 'package:flutter/material.dart';

class LogOrReg extends StatefulWidget {
  const LogOrReg({super.key});

  @override
  State<LogOrReg> createState() => _LogOrRegState();
}

class _LogOrRegState extends State<LogOrReg> {
  // Initially Login page is redirected
  bool showLoginPage = true;

  // Method for toggling pages
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(
        onTap: togglePage,
      );
    } else {
      return RegistrationScreen(
        onTap: togglePage,
      );
    }
  }
}
