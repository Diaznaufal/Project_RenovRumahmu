import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Help_Page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelpPage()),
        );
      },
      child: Container(
        height: 104,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xff0369C8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BUTUH BANTUAN?",
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    "Jika ada pertanyaan atau butuh konsultasi, klik di sini.",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            SvgPicture.asset(
              "assets/icon/help.svg",
              width: 90,
              height: 90,
              colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
