import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Home_Page.dart';
import 'package:flutter_application_1/Pages/Pesan_Page.dart';
import 'package:flutter_application_1/Pages/Profil_Page.dart';
import 'package:flutter_application_1/Pages/Proyek_Page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomMenu extends StatelessWidget {
  final int currentIndex;

  const BottomMenu({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 1, offset: Offset(3, 1)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _menuItem(
            context: context,
            index: 0,
            iconPath: "assets/icon/Home_Solid.svg",
            title: "Home",
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false,
              );
            },
          ),
          _menuItem(
            context: context,
            index: 1,
            iconPath: "assets/icon/Proyek.svg",
            title: "Proyek",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProyekPage()),
              );
            },
          ),
          _menuItem(
            context: context,
            index: 2,
            iconPath: "assets/icon/Pesan.svg",
            title: "Pesan",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PesanPage()),
              );
            },
          ),
          _menuItem(
            context: context,
            index: 3,
            iconPath: "assets/icon/Profil.svg",
            title: "Profil",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required BuildContext context,
    required int index,
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    final bool isActive = currentIndex == index;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: isActive ? 22 : 21,
            height: isActive ? 22 : 21,
            colorFilter: ColorFilter.mode(
              isActive ? const Color(0xff003466) : Colors.grey.shade600,
              BlendMode.srcIn,
            ),
          ),

          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Color(0xff003466) : Colors.grey.shade600,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
