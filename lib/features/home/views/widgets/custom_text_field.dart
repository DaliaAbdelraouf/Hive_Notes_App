import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.hint, this.lines, this.onSaved});

  final String hint;

  final int? lines;
  final void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Field is required';
        }

        if (value!.length < 10) {
          return "length";
        }
        return null;
      },

      keyboardType: TextInputType.text,
      maxLines: lines,
      decoration: InputDecoration(
          filled: true,
          hintText: hint,
          fillColor: const Color(0xff303030),
          hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
          focusedBorder: builderBorder(),
          enabledBorder: builderBorder(),
          border: const OutlineInputBorder()
          ),
      onSaved: onSaved,

    );
  }
}

OutlineInputBorder builderBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.white));
