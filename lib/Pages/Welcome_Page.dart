import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Login.dart';
import 'package:flutter_application_1/widgets/Register.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff003466),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset(
              "images/Logo renovrumahmu.png",
              height: 240,
              width: 240,
            ),
            Text(
              "Welcome",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 30,
                fontWeight: FontWeight.w600,
                letterSpacing: 6,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: "RenovRumahMu ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          "solusi mudah untuk renovasi rumah yang aman dan berkualitas",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 250,
              child: InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    expand: false,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Register(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(77),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: Color(0xff003466),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 250,
              child: InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    expand: false,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Login(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xff003466),

                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffffffff), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(77),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "RenovRumahMu © 2025",
                style: TextStyle(color: Color(0xffffffff), fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
