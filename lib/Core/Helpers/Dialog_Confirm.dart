import 'package:flutter/material.dart';

void showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required VoidCallback onConfirm,
  String confirmText = "Hapus",
}) {
  showDialog(
    context: context,

    builder: (_) {
      return Dialog(
        backgroundColor: Colors.white,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

        child: Padding(
          padding: EdgeInsets.all(24),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                width: 60,
                height: 60,

                decoration: BoxDecoration(
                  color: Colors.orange.withAlpha(20),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 34,
                ),
              ),

              SizedBox(height: 20),

              Text(
                title,

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),

              SizedBox(height: 10),

              Text(
                message,

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.grey.shade700,
                  fontFamily: "Inria Sans",
                ),
              ),

              SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),

                        side: BorderSide(color: Colors.grey.shade300),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      child: Text(
                        "Batal",

                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: "Inria Sans",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm();
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff003466),

                        foregroundColor: Colors.white,

                        elevation: 0,

                        padding: EdgeInsets.symmetric(vertical: 14),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      child: Text(
                        confirmText,

                        style: TextStyle(
                          fontFamily: "Inria Sans",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
