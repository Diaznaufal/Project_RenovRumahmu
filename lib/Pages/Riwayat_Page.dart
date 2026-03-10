import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Riwayat_Model.dart';
import 'package:flutter_application_1/widgets/Bottom_Menu.dart';
import 'package:flutter_application_1/widgets/Riwayat_List.dart';

class RiwayatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 35,
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.only(right: 24),
                    labelColor: Color(0xff045097),
                    indicatorColor: Color(0xff045097),
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),

                    unselectedLabelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    tabs: [
                      Tab(text: "Semua"),
                      Tab(text: "Proyek"),
                      Tab(text: "Material"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    RiwayatList(type: null),
                    RiwayatList(type: OrderType.renovasi),
                    RiwayatList(type: OrderType.material),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomMenu(currentIndex: 1),
      ),
    );
  }
}
