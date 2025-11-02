import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.isPassword = false,
    required this.fieldController,
    this.validate,
  });

  final TextEditingController fieldController;
  final String? hint;
  final bool isPassword;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
      child: TextFormField(
        style: TextStyle(fontSize: 20, color: Colors.black),
        validator: validate,
        controller: fieldController,
        obscureText: isPassword,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
