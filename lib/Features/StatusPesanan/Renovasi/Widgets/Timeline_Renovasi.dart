import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/Widgets/Riwayat_status.dart';
import '../../Models/Timeline_Status.dart';

class TrackingTimeline extends StatelessWidget {
  final int currentStep;

  const TrackingTimeline({super.key, required this.currentStep});
  @override
  Widget build(BuildContext context) {
    final List<TimelineStatus> statusList = [
      TimelineStatus(title: "Pembayaran terverifikasi"),
      TimelineStatus(title: "Jadwal kunjungan dikonfirmasi"),
      TimelineStatus(title: "Survey selesai"),
      TimelineStatus(title: "Pengerjaan berlangsung"),
      TimelineStatus(title: "Finishing"),
      TimelineStatus(title: "Selesai"),
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
