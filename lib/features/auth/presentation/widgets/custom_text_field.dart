import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String? Function(String?)? validator;
  const CustomTextField({super.key, required this.hint, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.lightBlue.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black38),
      ),
    );
  }
}
