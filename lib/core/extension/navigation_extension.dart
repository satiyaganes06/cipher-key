import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void showConfirmDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
    String? confirmText,
    String? cancelText,
    Color? confirmTextColor,
  }) {
    final theme = Theme.of(this);

    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(
                cancelText ?? 'Cancel',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                confirmText ?? 'Confirm',
                style: TextStyle(
                    color: confirmTextColor ?? theme.colorScheme.background),
              ),
              onPressed: onConfirm,
            ),
          ],
        );
      },
    );
  }
}
