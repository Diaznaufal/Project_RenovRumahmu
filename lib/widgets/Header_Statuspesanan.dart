import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Home_Page.dart';

class HeaderStatuspesanan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Color(0xff00B737),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(Icons.check, color: Colors.white, size: 40),
          ),
          SizedBox(height: 10),
          Text(
            "Pesanan Diproses!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text("ID Pesanan: SN-01-0000012", style: TextStyle(fontSize: 10)),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Color(0xff045097).withAlpha(60),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                "Estimasi Tiba: 23 Feb 2026",
                style: TextStyle(color: Color(0xff045097), fontSize: 10),
              ),
            ),
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
                (route) => false,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff045097),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Text(
                  "Kembali ke Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
