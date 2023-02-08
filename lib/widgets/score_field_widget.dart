import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoreField extends StatelessWidget {
  const ScoreField({
    super.key,
    required this.scoreController,
    required this.label,
  });

  final TextEditingController scoreController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextField(
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,
        controller: scoreController,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
        ],
        decoration: InputDecoration(
          label: Text(label),
          floatingLabelAlignment: FloatingLabelAlignment.center,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
          labelStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          hintText: '00',
          hintStyle:
              TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.4)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 3)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 3)),
        ),
      ),
    );
  }
}
