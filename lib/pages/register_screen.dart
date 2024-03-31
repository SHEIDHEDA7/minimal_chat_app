// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison, avoid_print

import 'package:chat_app/components/components.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/services/auth_service.dart';
// import 'package:chat_app_firebase/pages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  final void Function()? onTap;
  const RegistrationScreen({
    super.key,
    required this.onTap,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final email = TextEditingController();
  final pw = TextEditingController();
  final cpw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signUp() async {
      if (pw.text != cpw.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Passwords do not match",
            ),
          ),
        );
        return;
      }
      // Get auth service
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.registerUser(email.text, pw.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey,
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }

    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myBox(80, 0),
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 120,
                  child: Icon(
                    Icons.message,
                    size: 110,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              myBox(20, 0),
              const Text(
                "R E G I S T E R",
                style: kLargeText,
              ),
              myBox(30, 0),
              MyTextField(
                controller: email,
                obscureText: false,
                hint: "Email",
              ),
              myBox(30, 0),
              MyTextField(
                controller: pw,
                obscureText: true,
                hint: "Password",
              ),
              myBox(30, 0),
              MyTextField(
                controller: cpw,
                obscureText: true,
                hint: "Confirm Password",
              ),
              myBox(40, 0),
              MyButton(
                name: "S I G N   U P",
                onTap: signUp,
              ),
              myBox(35, 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a Member?",
                    style: kExtraSmall,
                  ),
                  myBox(0, 10),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login",
                        style: kPageChanger,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
