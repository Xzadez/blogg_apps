import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Widget? child;
  final Function(String) onChanged;
  final TextEditingController controller;
  const SearchField({
    super.key,
    this.child,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              style: const TextStyle(fontFamily: 'Telegraf'),
              decoration: const InputDecoration(
                hintText: 'Dogecoin to the Moon...',
                border: InputBorder.none,
              ),
            ),
          ),
          child!,
        ],
      ),
    );
  }
}
