import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final VoidCallback onPressed;
  final Widget? child;
  const CustomButton(
      {super.key, required this.onPressed, required this.width, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded corners
          ),
          padding:
              EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Padding
        ),
        child: child,
      ),
    );
  }
}
