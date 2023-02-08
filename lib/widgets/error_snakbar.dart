import 'package:flutter/material.dart';

void ErrorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        const Icon(Icons.error_outline_rounded, color: Colors.white),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
    backgroundColor: Colors.red,
  ));
}
