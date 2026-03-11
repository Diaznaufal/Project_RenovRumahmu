import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Welcome_Page.dart';
import 'package:flutter_application_1/Provider/AuthProvider.dart';
import 'package:flutter_application_1/Provider/Provider_Layanan.dart';
import 'package:flutter_application_1/widgets/Bottom_Menu.dart';
import 'package:flutter_application_1/widgets/Profil_Header_Card.dart';
import 'package:flutter_application_1/widgets/Status_Card.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
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

    return Scaffold(
      body: Stack(
        children: [
          /// Background Header
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Color(0xff003466),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
            ),
          ),

          /// Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.arrow_back, size: 25),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  /// Profile Card
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(height: 220, child: ProfilHeaderCard()),
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Status Proyek",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: 5),

                  SizedBox(
                    height: 157,
                    child: proyekProvider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : proyekList.isEmpty
                        ? Center(child: Text("Belum ada proyek"))
                        : PageView.builder(
                            controller: PageController(viewportFraction: 1),
                            itemCount: proyekList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                child: StatusCard(proyek: proyekList[index]),
                              );
                            },
                          ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Menu Detail",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),

                  Spacer(),

                  /// Logout Button
                  Consumer<AuthProvider>(
                    builder: (context, auth, _) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red.withAlpha(40),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            await auth.logout();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => WelcomePage()),
                              (route) => false,
                            );
                          },
                          child: Text(
                            "LOGOUT",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 5,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomMenu(currentIndex: 3),
    );
  }
}
