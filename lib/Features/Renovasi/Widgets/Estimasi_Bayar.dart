import 'dart:io';
import 'package:flutter_application_1/Data/Remote/Renovasi_Form/Pengerjaan_Options.dart';
import 'package:flutter_application_1/Features/Address/Provider/Addres_Provider.dart';
import 'package:flutter_application_1/Features/Renovasi/Models/Renovasi_OpsiPilih.dart';
import 'package:flutter_application_1/Features/Renovasi/Widgets/Elemens/Estimasi_harga_Renov.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Data/Remote/Renovasi_Form/Area_Options.dart';
import '../../../Data/Remote/Renovasi_Form/Kebutuhan_Options.dart';
import '../../../Data/Remote/Renovasi_Form/Pekerjaan_Options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EstimasiBayar extends StatefulWidget {
  @override
  State<EstimasiBayar> createState() => _EstimasiBayarState();
}

class _EstimasiBayarState extends State<EstimasiBayar> {
  final promoController = TextEditingController();

  @override
  void dispose() {
    promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<RenovasiProvider>();
    final media = prov.formData.media ?? [];

    int photoCount = media.where((file) {
      final lower = file.toLowerCase();
      return lower.endsWith('.jpg') ||
          lower.endsWith('jpeg') ||
          lower.endsWith('png');
    }).length;

    int videoCount = media.where((file) {
      final lower = file.toLowerCase();
      return lower.endsWith('.mp4') ||
          lower.endsWith('.mov') ||
          lower.endsWith('.avi') ||
          lower.endsWith('.mkv');
    }).length;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (media.isNotEmpty)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
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
                        right: 10,
                        bottom: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.photo_library,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 3),
                              Text(
                                "$photoCount Foto, ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),

                              Text(
                                "$videoCount vid",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 16),
              Text(
                "Rincian Proyek",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 120,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.handyman,
                          size: 30,
                          color: Color(0xff004597),
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Consumer<RenovasiProvider>(
                        builder: (context, provider, child) {
                          final data = provider.formData;

                          final kebutuhanTitle = kebutuhanOptions
                              .firstWhere(
                                (item) => item.value == data.kebutuhan,
                                orElse: () =>
                                    RenovasiOpsipilih(value: '', title: '-'),
                              )
                              .title;

                          final areaTitle = areaOptions
                              .firstWhere(
                                (item) => item.value == data.area,
                                orElse: () =>
                                    RenovasiOpsipilih(value: '', title: '-'),
                              )
                              .title;

                          final tingkatTitle = pekerjaanOptions
                              .firstWhere(
                                (item) => item.value == data.tingkatKerusakan,
                                orElse: () =>
                                    RenovasiOpsipilih(value: '', title: '-'),
                              )
                              .title;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$kebutuhanTitle ・ $areaTitle",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inria Sans",
                                  color: Color(0xff045097),
                                ),
                              ),

                              Text(
                                tingkatTitle,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Inria Sans",
                                  color: Colors.black54,
                                ),
                              ),

                              if ((data.deskripsi ?? "").isNotEmpty) ...[
                                const SizedBox(height: 2),

                                Text(
                                  data.deskripsi!,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Inria Sans",
                                    color: Colors.black87,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inria Sans",
                          color: Color(0xff0369C8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 120,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 28,
                          height: 30,
                          child: SizedBox(
                            width: 27,
                            height: 29,
                            child: SvgPicture.asset(
                              "assets/icon/Kalender_Jam.svg",
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                Color(0xff045097),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Consumer<RenovasiProvider>(
                        builder: (context, provider, child) {
                          final data = provider.formData;

                          final tanggal = DateFormat(
                            'dd MM yyyy',
                          ).format(data.tanggalKunjungan!);

                          final jam = data.jamKunjungan;

                          final pengerjaanTitle = pengerjaanOptions
                              .firstWhere(
                                (item) => item.value == data.pengerjaan,
                                orElse: () =>
                                    RenovasiOpsipilih(value: '', title: '-'),
                              )
                              .title;

                          final alamatProv = context.watch<AddressProvider>();

                          final alamat =
                              alamatProv.selectedAddress?.fullAddress ?? "-";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Kunjungan: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inria Sans",
                                        color: Color(0xff045097),
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "$tanggal ・ $jam",
                                      style: TextStyle(
                                        fontFamily: "Inria Sans",
                                        color: Color(0xff045097),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                pengerjaanTitle,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Inria Sans",
                                  color: Colors.black54,
                                ),
                              ),

                              const SizedBox(height: 2),

                              Text(
                                alamat,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Inria Sans",
                                  color: Colors.black87,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inria Sans",
                          color: Color(0xff0369C8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Estimasi Biaya",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              Text(
                "Punya Kode Promo?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                  color: Color(0xff0369C8),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: TextField(
                          controller: promoController,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "Inria Sans",
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: "Masukan kode Promo",
                            hintStyle: TextStyle(
                              color: Color(0xE0B0B2B6),
                              fontFamily: "Inria Sans",
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  InkWell(
                    onTap: () {
                      final code = promoController.text.trim();

                      final success = prov.applyPromo(code);
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Kode promo tidak ditemukan")),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xff0369C8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Gunakan",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              EstimasiHargaRenovasi(),
            ],
          ),
        ),
      ),
    );
  }
}
