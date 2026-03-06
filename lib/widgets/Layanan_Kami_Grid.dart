import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Bangunbaru_Page.dart';
import 'package:flutter_application_1/Pages/Perawatan_Page.dart';
import 'package:flutter_application_1/Pages/Renovasi_Page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/Pages/Material_Page.dart';
import '../models/Layanan_Kami.dart';

class LayananKamiGrid extends StatelessWidget {
  const LayananKamiGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LayananKami> layananList = [
      LayananKami(
        title: "Bangun Baru",
        subtitle: "Pembangunan unit baru",
        icon: "assets/icon/House.svg",
        color: Color(0xFF1C87EB),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BangunbaruPage()),
          );
        },
      ),
      LayananKami(
        title: "Renovasi",
        subtitle: "Struktur & Interior",
        icon: "assets/icon/solid_tools.svg",
        color: Color(0xFF2E9B4F),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RenovasiPage()),
          );
        },
      ),
      LayananKami(
        title: "Perawatan",
        subtitle: "AC, Listrik dan Kebersihan",
        icon: "assets/icon/Broom.svg",
        color: Color(0xFFF29900),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PerawatanPage()),
          );
        },
      ),
      LayananKami(
        title: "Material",
        subtitle: "Bahan bangunan pilihan",
        icon: "assets/icon/shop_bag.svg",
        color: Color(0xFFFFC107),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PageMaterial()),
          );
        },
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: layananList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.65,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = layananList[index];

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: item.onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.color.withAlpha(10),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: item.color),
            ),

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    item.icon,
                    width: 40,
                    height: 40,
                    colorFilter: ColorFilter.mode(item.color, BlendMode.srcIn),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
