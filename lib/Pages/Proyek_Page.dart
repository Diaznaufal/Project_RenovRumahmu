import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Bottom_Menu.dart';

class ProyekPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black.withAlpha(80),
        titleSpacing: 1,
        toolbarHeight: 60,
        title: Text(
          "RIWAYAT PESANAN",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(child: Column()),
      bottomNavigationBar: BottomMenu(currentIndex: 1),
    );
  }
}
