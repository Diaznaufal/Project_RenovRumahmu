import 'package:flutter/material.dart';

void showErrorDialog(
  BuildContext context,
  String message, {
  String title = "Terjadi Kesalahan",
}) {
  showDialog(
    context: context,
    barrierDismissible: true,

    builder: (_) {
      return Dialog(
        backgroundColor: Colors.white,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

        child: Padding(
          padding: EdgeInsets.all(14),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Container(
                width: 60,
                height: 60,

                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(20),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 32,
                ),
              ),

              SizedBox(height: 15),

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

              SizedBox(height: 15),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                    "Mengerti",

                    style: TextStyle(
                      fontFamily: "Inria Sans",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
