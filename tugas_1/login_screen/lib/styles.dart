import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(20.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
}

ButtonStyle buildButtonStyle() {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Color(0xFFB37D1D),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    elevation: 5,
  );
}

