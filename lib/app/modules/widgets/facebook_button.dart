import 'package:flutter/material.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return SizedBox(
      width: width / 2.5,
      child: ElevatedButton.icon(
        onPressed: () {
          // Add Facebook login functionality here
        },
        icon: Icon(Icons.facebook, color: Colors.white),
        label: Text(
          'Facebook',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3b5998), // Facebook blue color
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
