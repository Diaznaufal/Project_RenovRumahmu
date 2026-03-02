import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Home_Page.dart';
import 'package:flutter_application_1/Pages/Welcome_Page.dart';
import 'package:flutter_application_1/Pages/Walkthrough.dart';
import 'package:flutter_application_1/service/Local_Stage_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _checkFlow();
    });
  }

  Future<void> _checkFlow() async {
    final storage = LocalStorageService();

    bool isWalkthroughSeen = await storage.isWalkthroughSeen();
    bool isLoggedIn = await storage.isLoggedIn();

    if (!isWalkthroughSeen) {
      _goTo(WalkthroughPage());
    } else if (!isLoggedIn) {
      _goTo(WelcomePage());
    } else {
      _goTo(HomePage());
    }
  }

  void _goTo(Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003466),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/Logo renovrumahmu.png"),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
