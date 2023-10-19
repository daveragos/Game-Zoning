import 'package:flutter/material.dart';

Padding textField(
    {required TextEditingController nameController,
    required label,
    required keyType,
    required icon,
    required hide}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: nameController,
      keyboardType: keyType,
      obscureText: hide,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
