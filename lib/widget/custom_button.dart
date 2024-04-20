import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.onPressed, required this.text, super.key});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Theme.of(context).shadowColor,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
