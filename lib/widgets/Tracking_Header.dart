import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrackingHeader extends StatelessWidget {
  final int currentStep;
  const TrackingHeader({super.key, required this.currentStep});

  String getIconPath() {
    if (currentStep <= 2) {
      return "assets/icon/Box.svg";
    } else if (currentStep <= 4) {
      return "assets/icon/Kurir.svg";
    } else {
      return "assets/icon/Check.svg";
    }
  }

  String getStatus() {
    if (currentStep <= 2) {
      return "Pesanan Disiapkan";
    } else if (currentStep <= 4) {
      return "Pesanan Dikirim";
    } else {
      return "Pesanan Selesai";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              getIconPath(),
              width: 55,
              height: 40,
              colorFilter: ColorFilter.mode(Color(0xff045097), BlendMode.srcIn),
            ),
            SizedBox(height: 10),
            Text(
              getStatus(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "ID Pesanan: SH-01-0000012",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            SizedBox(height: 6),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: Color(0xff045097).withAlpha(80),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Estimasi Tiba: 23 Feb 2026",
                style: TextStyle(fontSize: 10, color: Color(0xff045097)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
