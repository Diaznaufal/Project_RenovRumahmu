import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Welcome_Page.dart';
import 'package:flutter_application_1/service/Local_Stage_service.dart';

class WalkthroughPage extends StatefulWidget {
  @override
  State<WalkthroughPage> createState() => _WalkthroughPageState();
}

class _WalkthroughPageState extends State<WalkthroughPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Selamat Datang di RenovRumahMu",
      "desc":
          "Solusi mudah untuk merencanakan dan mewujudkan renovasi rumah impianmu.",
      "image": "images/Logo renovrumahmu_biru.png",
    },

    {
      "title": "Temukan Kontraktor Terpercaya",
      "desc":
          "Cari dan pilih kontraktor sesuai kebutuhan, lokasi, dan anggaranmu.",
      "image": "images/Logo renovrumahmu_biru.png",
    },
    {
      "title": "Mulai Renovasi Sekarang",
      "desc":
          "Login atau daftar untuk mulai mengelola proyek renovasimu dengan mudah.",
      "image": "images/Logo renovrumahmu_biru.png",
    },
  ];

  Future<void> finishWalkthrough() async {
    final storage = LocalStorageService();
    await storage.setWalkthroughSeen();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => WelcomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // PAGEVIEW
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(pages[index]['image']!, width: 220),
                    SizedBox(height: 30),
                    Text(
                      pages[index]['title']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        pages[index]['desc']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // DOT INDICATOR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => Container(
                margin: EdgeInsets.all(4),
                width: currentIndex == index ? 14 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentIndex == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // BUTTON
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: currentIndex == pages.length - 1
                ? ElevatedButton(
                    onPressed: finishWalkthrough,
                    child: Text("Mulai"),
                  )
                : ElevatedButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text("Next"),
                  ),
          ),
        ],
      ),
    );
  }
}
