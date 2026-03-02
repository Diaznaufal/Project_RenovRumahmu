import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/Pembayaran_Model.dart';

class PembayaranCard extends StatelessWidget {
  final PembayaranKategoriModel category;
  final String subtitle;
  final VoidCallback onTap;
  final bool isSelected;

  const PembayaranCard({
    super.key,
    required this.category,
    required this.subtitle,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              SvgPicture.asset(
                category.iconPath,
                width: 26,
                height: 26,
                colorFilter: ColorFilter.mode(
                  isSelected ? Color(0xff045097) : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Color(0xff045097) : Colors.black,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(subtitle, style: TextStyle(fontSize: 9)),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: isSelected ? Color(0xff045097) : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
