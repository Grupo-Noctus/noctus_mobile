import 'package:flutter/material.dart';

const inputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.white),
  borderRadius: BorderRadius.all(Radius.circular(16)),
);

const labelTextStyle = TextStyle(color: Colors.white38);
const inputTextStyle = TextStyle(color: Colors.white);

InputDecoration customInputDecoration(String label) => InputDecoration(
  labelText: label,
  labelStyle: labelTextStyle,
  enabledBorder: inputBorder,
  focusedBorder: inputBorder,
  errorBorder: inputBorder,
  focusedErrorBorder: inputBorder,
);

const buttonTextStyle = TextStyle(
  color: Color(0xFF6BFF50),
  fontWeight: FontWeight.bold,
  fontFamily: 'Open Sans',
);
