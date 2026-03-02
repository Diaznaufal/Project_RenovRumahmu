import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/Provider_Layanan.dart';
import '../Provider/AuthProvider.dart';

import '../widgets/Banner_Iklan.dart';
import '../widgets/Bottom_Menu.dart';
import '../widgets/Help_Card.dart';
import '../widgets/Layanan_Kami_Grid.dart';
import '../widgets/Status_Card.dart';

import 'Notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProviderLayanan>().fetchProyek();
    });
  }

  @override
  Widget build(BuildContext context) {
    final proyekProvider = context.watch<ProviderLayanan>();
    final proyekList = proyekProvider.proyekList;

    final screenWidth = MediaQuery.of(context).size.width;
    final bannerWidth = screenWidth - 32;
    final bannerHeight = bannerWidth * 140 / 328;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black.withAlpha(77),
        titleSpacing: 15,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: Row(
          children: [
            Image.asset(
              "images/Logo renovrumahmu_biru.png",
              width: 55,
              height: 55,
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lokasi Anda",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                Row(
                  children: [
                    Text(
                      "Purwakarta",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Color(0xff003466)),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NotifikasiPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xff0060BD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Badge(
                  offset: Offset(7, -7),
                  backgroundColor: Colors.red,
                  label: Text("3"),
                  textColor: Colors.white,
                  child: Transform.rotate(
                    angle: -math.pi / 8,
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Greeting
                Consumer<AuthProvider>(
                  builder: (context, auth, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Selamat Datang,",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              auth.name.isNotEmpty
                                  ? auth.name[0].toUpperCase() +
                                        auth.name.substring(1)
                                  : "",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Mau memulai proyek baru?",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 25),

                /// Banner
                BannerIklan(
                  images: [
                    "images/Banner.png",
                    "images/Banner2.png",
                    "images/Banner3.png",
                    "images/Banner4.png",
                  ],
                  height: bannerHeight,
                ),

                SizedBox(height: 20),

                Text(
                  "Layanan Kami",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 15),

                LayananKamiGrid(),

                SizedBox(height: 20),

                Text(
                  "Status Proyek",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 10),

                /// Status Proyek List
                SizedBox(
                  height: 157,
                  child: proyekProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : proyekList.isEmpty
                      ? Center(child: Text("Belum ada proyek"))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: proyekList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 10,
                              ),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.91,
                                child: StatusCard(proyek: proyekList[index]),
                              ),
                            );
                          },
                        ),
                ),

                SizedBox(height: 15),

                Text(
                  "Bantuan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 15),

                HelpCard(),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomMenu(currentIndex: 0),
    );
  }
}
