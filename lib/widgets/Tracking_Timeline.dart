import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Riwayat_status.dart';
import '../models/Order_status.dart';

class TrackingTimeline extends StatelessWidget {
  final int currentStep;

  const TrackingTimeline({super.key, required this.currentStep});
  @override
  Widget build(BuildContext context) {
    final List<OrderStatus> statusList = [
      OrderStatus(
        title: "Pembayaran terverifikasi",
        subtitle: "20 Feb 2026, 14:00",
      ),
      OrderStatus(
        title: "Pesanan sedang disiapkan",
        subtitle: "20 Feb 2026, 14:30",
      ),
      OrderStatus(
        title: "Pengirim sedang mengatur pengiriman",
        subtitle: "20 Feb 2026, 15:00",
      ),
      OrderStatus(
        title: "Pesanan sedang dikirim dari gudang",
        subtitle: "20 Feb 2026, 16:00",
      ),
      OrderStatus(
        title: "Pesanan menuju lokasi anda",
        subtitle: "20 Feb 2026, 18:00",
      ),
      OrderStatus(title: "Pesanan telah tiba", subtitle: "20 Feb 2026, 20:00"),
    ];

    final visibleStatus = statusList.sublist(
      0,
      (currentStep + 1).clamp(0, statusList.length),
    );

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: visibleStatus.length,
          itemBuilder: (context, index) {
            return RiwayatStatus(
              status: visibleStatus[index],
              index: index,
              currentStep: currentStep,
              isLast: index == visibleStatus.length - 1,
            );
          },
        ),
      ],
    );
  }
}
