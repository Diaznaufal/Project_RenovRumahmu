import 'package:flutter/material.dart';

void showErrorDialog(
  BuildContext context,
  String message, {
  String title = 'Terjadi Kesalahan',
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialog(
      alignment: Alignment.center,
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      contentPadding: EdgeInsets.fromLTRB(20, 12, 20, 0),
      actionsPadding: EdgeInsets.fromLTRB(20, 8, 20, 16),
      title: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      content: Text(message, style: TextStyle(fontSize: 12)),
      actions: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    ),
  );
}
