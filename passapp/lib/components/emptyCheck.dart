import 'package:flutter/material.dart';

bool isEmpty(TextEditingController N) {
  String text = N.text.trim();
  if (text.isEmpty) {
    return true;
  } else {
    return false;
  }
}
