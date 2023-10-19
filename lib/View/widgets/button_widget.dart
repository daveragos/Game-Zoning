import 'package:flutter/material.dart';

ElevatedButton buttonWidget({
  required OnTap,
  required title,
  required context,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(200, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: OnTap,
    child: Text(title),
  );
}
