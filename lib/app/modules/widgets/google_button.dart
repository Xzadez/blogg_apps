import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return SizedBox(
      width: width / 2.5,
      child: OutlinedButton.icon(
        onPressed: () {
          // Add Google login functionality here
        },
        icon: Image.asset(
          'assets/images/google.png',
          width: 17,
        ),
        label: Text(
          'Google',
          style: TextStyle(color: Colors.black),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.black), // Border color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded edges
          ),
          padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
        ),
      ),
    );
  }
}
