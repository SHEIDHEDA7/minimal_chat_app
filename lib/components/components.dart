import 'package:flutter/material.dart';

// Text Field
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hint;

  const MyTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        hintText: "Enter $hint",
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w300,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

// Login or Sign up button
class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.name,
    required this.onTap,
  });

  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Sized box
myBox(double kHeight, double kWidth) {
  return SizedBox(
    height: kHeight,
    width: kWidth,
  );
}
