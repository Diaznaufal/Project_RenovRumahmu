import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Renovasi/Models/Metode_proyek.dart';

class MetodePembayaranProyek extends StatelessWidget {
  final List<MetodeProyek> metodeList;
  final String? selectedCode;
  final Function(int index, String code) onSelected;

  const MetodePembayaranProyek({
    super.key,
    required this.metodeList,
    required this.selectedCode,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: metodeList.length,
        itemBuilder: (context, index) {
          final opsi = metodeList[index];
          final isSelected = selectedCode == opsi.code;

          return GestureDetector(
            onTap: () => onSelected(index, opsi.code),
            child: Container(
              width: 182,
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Color(0xff0369C8) : Colors.grey.shade200,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opsi.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Inria Sans",
                      color: Color(0xff045097),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        opsi.desc,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: "Inria Sans",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
