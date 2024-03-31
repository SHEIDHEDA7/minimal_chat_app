import 'dart:async';

import 'package:chat_app/constants.dart';
import 'package:chat_app/services/auth_gateway.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      // Moving to another screen sequently
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthGate()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Hero(
          tag: 'logo',
          child: SizedBox(
            height: 500,
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/login_animation.json"),
                const SizedBox(height: 30),
                const SizedBox(
                  child: Text(
                    "C H A T  A P P",
                    style: kMediumText,
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
