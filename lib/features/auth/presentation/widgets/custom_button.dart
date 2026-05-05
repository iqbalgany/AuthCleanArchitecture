import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.indigoAccent),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        fixedSize: WidgetStatePropertyAll(
          Size(MediaQuery.sizeOf(context).width, 50),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
