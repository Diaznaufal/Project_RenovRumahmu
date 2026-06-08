import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/Pengiriman_Model.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class ShippingSection extends StatelessWidget {
  final List<PengirimanModel> shippingList;
  final int? selectedIndex;
  final Function(int index, int cost) onSelected;

  const ShippingSection({
    super.key,
    required this.shippingList,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 89,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: shippingList.length,
        itemBuilder: (context, index) {
          final opsi = shippingList[index];
          final isSelected = selectedIndex == index;
          final now = DateTime.now();
          final minDate = now.add(Duration(days: opsi.minDay));
          final maxDate = now.add(Duration(days: opsi.maxDay));

          final formatter = DateFormat('d MMM', 'id_ID');

          return GestureDetector(
            onTap: () => onSelected(index, opsi.cost),
            child: Container(
              width: 183,
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                      fontFamily: "Inria Sans",
                      color: Color(0xff0369C8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formatRupiah.format(opsi.cost),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Inria Sans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        "Estimasi tiba",
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: "Inria Sans",
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        opsi.minDay == 0
                            ? "hari ini"
                            : "${formatter.format(minDate)} - ${formatter.format(maxDate)}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: "Inria Sans",
                          color: Colors.grey,
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
