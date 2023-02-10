import 'package:flutter/material.dart';

enum CoordsType { x0, x1, y0, y1 }

void snack(BuildContext context, Widget content, [SnackBarAction? action]) {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: content, action: action),
    );
  }
}