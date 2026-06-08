import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/StatusPesanan/Renovasi/Widgets/Rincian_Renov.dart';
import 'package:flutter_application_1/Features/StatusPesanan/Renovasi/Widgets/Timeline_Renovasi.dart';
import 'package:intl/intl.dart';
import '../../../RiwayatPesanan/Models/Riwayat_Model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

String getServiceIconPath(OrderType type) {
  switch (type) {
    case OrderType.material:
      return "assets/icon/shop_bag.svg";
    case OrderType.renovasi:
      return "assets/icon/solid_tools.svg";
    case OrderType.bangunBaru:
      return "assets/icon/House.svg";
    case OrderType.perawatan:
      return "assets/icon/Broom.svg";
  }
}

Color getServiceColor(OrderType type) {
  switch (type) {
    case OrderType.material:
      return Color(0xFFFFC107);
    case OrderType.renovasi:
      return Color(0xFF2E9B4F);
    case OrderType.bangunBaru:
      return Color(0xFF1C87EB);
    case OrderType.perawatan:
      return Color(0xFFF29900);
  }
}

String getStatusLabelRenovasi(RenovasiStatus status) {
  switch (status) {
    case RenovasiStatus.menunggupembayaran:
      return "Menunggu pembayaran";
    case RenovasiStatus.survey:
      return "Menunggu Survey";
    case RenovasiStatus.berjalan:
      return "Berjalan";
    case RenovasiStatus.selesai:
      return "Selesai";
  }
}

Color getStatusRenovasiColor(RenovasiStatus status) {
  switch (status) {
    case RenovasiStatus.menunggupembayaran:
      return Color(0xFFFFC107);
    case RenovasiStatus.survey:
      return Color(0xff3B82F6);
    case RenovasiStatus.berjalan:
      return Color(0xff3B82F6);
    case RenovasiStatus.selesai:
      return Color(0xff009236);
  }
}

String getStatusTitle(RenovasiStep step) {
  switch (step) {
    case RenovasiStep.pembayaranBelumSelesai:
      return "Pembayaran Belum Diselesaikan";
    case RenovasiStep.membuatJadwal:
      return "Membuat Jadwal Kunjungan";
    case RenovasiStep.surveyDijadwalkan:
      return "Survey Dijadwalkan";
    case RenovasiStep.pengerjaanberlangsung:
      return "Pengerjaan Berlangsung";
    case RenovasiStep.finishing:
      return "Finishing";
    case RenovasiStep.proyekSelesai:
      return "Selesai";
  }
}

String getStatusDescription(RenovasiStep step) {
  switch (step) {
    case RenovasiStep.pembayaranBelumSelesai:
      return "Selesaikan pembayaran untuk memulai proyek";
    case RenovasiStep.membuatJadwal:
      return "Menunggu Konfirmasi Jadwal Kunjungan";
    case RenovasiStep.surveyDijadwalkan:
      return "Teknisi akan melakukan survey sesuai jadwal kunjungan.";
    case RenovasiStep.pengerjaanberlangsung:
      return "Tahap pemasangan atap";
    case RenovasiStep.finishing:
      return "Pengecatan Ulang Atap";
    case RenovasiStep.proyekSelesai:
      return "";
  }
}

List<Widget> _BuildRenovasiButtons(BuildContext context, RiwayatModel item) {
  final status = item.renovasiStep;

  if (status == null) {
    return [];
  }
  switch (status) {
    case RenovasiStep.pembayaranBelumSelesai:
      return [_buildPrimaryButton("Bayar Sekarang", onPressed: () {})];
    case RenovasiStep.membuatJadwal:
      return [];
    case RenovasiStep.surveyDijadwalkan:
    case RenovasiStep.pengerjaanberlangsung:
      return [_buildPrimaryButton("Hubungi Teknisi", onPressed: () {})];
    case RenovasiStep.finishing:
      return [_buildPrimaryButton("Bayar Sisa Tagihan", onPressed: () {})];
    case RenovasiStep.proyekSelesai:
      return [
        _buildPrimaryButton("Beri Penilaian dan Ulasan", onPressed: () {}),
        SizedBox(height: 15),
        _buildSecondButton("Lihat Invoice", onPressed: () {}),
      ];
  }
}

class StatusProyek extends StatelessWidget {
  final RiwayatModel order;
  const StatusProyek({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final media = order.imagePath ?? [];
    final status = order.renovasiStatus ?? RenovasiStatus.menunggupembayaran;

    final step = order.renovasiStep ?? RenovasiStep.pembayaranBelumSelesai;
    final showPicTeknisi = step.index >= RenovasiStep.surveyDijadwalkan.index;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black.withAlpha(80),
        titleSpacing: 1,
        toolbarHeight: 60,
        title: Text(
          "STATUS PROYEK",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "Inria Sans",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        child: Image.file(
                          File(media.first),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 3),
                            Text(
                              "Renovasi ${(order.area)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inria Sans",
                              ),
                            ),

                            Text(
                              DateFormat(
                                'dd MMMM yyyy',
                                'id_ID',
                              ).format(order.tanggalKunjungan!),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: getServiceColor(order.type).withAlpha(90),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          getServiceIconPath(order.type),
                          colorFilter: ColorFilter.mode(
                            getServiceColor(order.type),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: getStatusRenovasiColor(status),

                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        getStatusLabelRenovasi(status),

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: "Inria Sans",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${((order.progress ?? 0) * 100).toInt()}%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: "Inria Sans",
                        color: Color(0xff045097),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: (order.progress ?? 0).toDouble(),
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xff045097),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  getStatusTitle(step),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff045097),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  getStatusDescription(step),
                  style: TextStyle(fontSize: 12, fontFamily: "Inria Sans"),
                ),
                SizedBox(height: 10),
                Text(
                  "Timeline",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria Sans",
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(77),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    child: TrackingTimeline(currentStep: 6),
                  ),
                ),
                if (showPicTeknisi) ...[
                  SizedBox(height: 16),
                  _buildPicTeknisi(),
                ],
                SizedBox(height: 16),
                Text(
                  "Rincian",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria Sans",
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                RincianRenov(order: order),
                SizedBox(height: 16),
                ..._BuildRenovasiButtons(context, order),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildPicTeknisi() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "PIC/Teknisi",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Inria Sans",
          fontSize: 16,
        ),
      ),
      SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              Image.asset("assets/images/teknisi.png"),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Budi Santoso",
                    style: TextStyle(
                      color: Color(0xff045097),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inria Sans",
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Tukang Bangunan",
                    style: TextStyle(
                      fontFamily: "Inria Sans",
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "⭐ 4.9",
                    style: TextStyle(
                      fontFamily: "Inria Sans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildPrimaryButton(String text, {required VoidCallback onPressed}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Color(0xff045097),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "Inria Sans",
        ),
      ),
    ),
  );
}

Widget _buildSecondButton(String text, {required VoidCallback onPressed}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Color(0xff009236),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "Inria Sans",
        ),
      ),
    ),
  );
}
