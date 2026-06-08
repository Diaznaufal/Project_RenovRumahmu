import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/RiwayatPesanan/Pages/Riwayat_Page.dart';
import 'package:flutter_application_1/Features/StatusPesanan/Renovasi/Models/Status_Proyek.dart';
import 'package:flutter_svg/svg.dart';

class StatusCard extends StatelessWidget {
  final StatusProyek proyek;

  const StatusCard({super.key, required this.proyek});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RiwayatPage()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/icon/solid_tools.svg",
                      width: 30,
                      height: 30,
                      colorFilter: ColorFilter.mode(
                        Color(0xFF2E9B4F),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          proyek.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Inria Sans",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          proyek.id,
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: "Inria Sans",
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xff045097).withAlpha(60),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    proyek.status,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blue.shade900,
                      fontFamily: "Inria Sans",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Progres", style: TextStyle(fontSize: 12)),
                Text(
                  "${(proyek.progres * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff045097),
                    fontFamily: "Inria Sans",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: proyek.progres,
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info_rounded, size: 14, color: Colors.grey.shade600),
                SizedBox(width: 4),
                Text(
                  "Tahap: ${proyek.tahap}",
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: "Inria Sans",
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
