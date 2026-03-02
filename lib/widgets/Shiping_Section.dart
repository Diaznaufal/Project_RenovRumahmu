import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Pengiriman_Model.dart';

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
      height: 95,
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
              width: 190,
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Color(0xff0369C8) : Colors.grey.shade200,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opsi.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0369C8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    formatRupiah.format(opsi.cost),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    opsi.minDay == 0
                        ? "Tiba hari ini"
                        : "Estimasi tiba ${formatter.format(minDate)} - ${formatter.format(maxDate)}",
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
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
