import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback? ontap;

  const CategoryRow({
    super.key,
    required this.title,
    this.isActive = false,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Color(0xff0060BD) : Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isActive ? Colors.white : Color(0xff487197),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
