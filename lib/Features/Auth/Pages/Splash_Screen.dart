import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Home/Pages/Home_Page.dart';
import 'package:flutter_application_1/Features/Auth/Pages/Welcome_Page.dart';
import 'package:flutter_application_1/Features/Auth/Pages/Walkthrough.dart';
import 'package:flutter_application_1/Core/service/Local_Stage_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );

    _fadeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );

    Future.delayed(Duration(milliseconds: 1000), () {
      _controller.forward();
    });

    Future.delayed(Duration(milliseconds: 3500), () {
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(
                          0.25 * _controller.value,
                        ),
                        blurRadius: 80,
                        spreadRadius: 25,
                      ),
                    ],
                  ),
                );
              },
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Logo renovrumahmu.png",
                      height: 700,
                      width: 700,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
