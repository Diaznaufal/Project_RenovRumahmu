import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Home_Page.dart';
import 'package:flutter_application_1/Pages/Pesan_Page.dart';
import 'package:flutter_application_1/Pages/Profil_Page.dart';
import 'package:flutter_application_1/Pages/Riwayat_Page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomMenu extends StatelessWidget {
  final int currentIndex;

  const BottomMenu({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// HOME
          _menuItem(
            context: context,
            index: 0,
            iconOutline: "assets/icon/Home_Outline.svg",
            iconSolid: "assets/icon/Home_Solid.svg",
            title: "Home",
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
                (route) => false,
              );
            },
          ),

          /// RIWAYAT
          _menuItem(
            context: context,
            index: 1,
            iconOutline: "assets/icon/Proyek_Outline.svg",
            iconSolid: "assets/icon/Proyek_Solid.svg",
            title: "Riwayat",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RiwayatPage()),
              );
            },
          ),

          /// PESAN
          _menuItem(
            context: context,
            index: 2,
            iconOutline: "assets/icon/Pesan_Outline.svg",
            iconSolid: "assets/icon/Pesan_Solid.svg",
            title: "Pesan",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PesanPage()),
              );
            },
          ),

          /// PROFIL
          _menuItem(
            context: context,
            index: 3,
            iconOutline: "assets/icon/Profil_Outline.svg",
            iconSolid: "assets/icon/Profil_Solid.svg",
            title: "Profil",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilPage()),
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
    required String iconOutline,
    required String iconSolid,
    required String title,
    required VoidCallback onTap,
  }) {
    final bool isActive = currentIndex == index;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// ICON
          SvgPicture.asset(
            isActive ? iconSolid : iconOutline,
            width: 23,
            height: 23,
            colorFilter: ColorFilter.mode(
              isActive ? const Color(0xff003466) : Colors.grey.shade600,
              BlendMode.srcIn,
            ),
          ),

          const SizedBox(height: 4),

          /// TEXT
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xff003466) : Colors.grey.shade600,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
