// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

// import 'package:chat_app_firebase/pages/chat_screen.dart';
import 'package:chat_app/components/components.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;

  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailC = TextEditingController();
  // 111@gmail.com
  final TextEditingController pwC = TextEditingController();
  // 111111

  void signIn() async {
    // Getting the auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
    try {
      // Our method
      await authService.signInWithEmailPassword(
        emailC.text,
        pwC.text,
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey.shade300,
          content: Text(
            e.toString(),
          ),
        ),
      );
      Navigator.pop(context);
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text(e.toString()),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* So that when keyboard pops up there is no pixel error*/
      // resizeToAvoidBottomInset: false,
      /*Or
       body: SingleChildScrollView(
       physics: NeverScrollableScrollPhysics(),
       but here the Content of the page will move up
      */
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              myBox(60, 0),
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 150,
                  child: Icon(
                    Icons.lock,
                    size: 120,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
              myBox(20, 0),
              const Text(
                "L O G I N",
                style: kLargeText,
              ),
              myBox(20, 0),
              MyTextField(
                controller: emailC,
                obscureText: false,
                hint: "Email",
              ),
              myBox(40, 0),
              MyTextField(
                controller: pwC,
                obscureText: true,
                hint: "Password",
              ),
              myBox(50, 0),
              MyButton(
                name: "S I G N   I N",
                onTap: () => signIn(),
              ),
              myBox(40, 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "New Member?",
                    style: kExtraSmall,
                  ),
                  myBox(0, 10),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Register here", style: kPageChanger),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
