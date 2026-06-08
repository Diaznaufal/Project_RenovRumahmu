import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Widgets/Bottom_Menu.dart';
import 'package:flutter_application_1/Features/DetailPesanan/widgets/Tracking_Header.dart';
import 'package:flutter_application_1/Features/StatusPesanan/Material/Widgets/Tracking_Timeline_material.dart';
import '../../RiwayatPesanan/Models/Riwayat_Model.dart';

class Detailpesanan2Page extends StatelessWidget {
  final RiwayatModel order;
  const Detailpesanan2Page({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black.withAlpha(80),
        titleSpacing: 1,
        toolbarHeight: 60,
        title: Text(
          "DETAIL PESANAN",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TrackingHeader(currentStep: 2, data: order),
            SizedBox(height: 45),
            Text(
              "Status Pesanan",
              style: TextStyle(fontSize: 15, fontFamily: "Inria Sans"),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(44),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 15),
                child: TrackingTimeline(currentStep: 3),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff045097),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      "Kembali",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inria Sans",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(currentIndex: 1),
    );
  }
}
