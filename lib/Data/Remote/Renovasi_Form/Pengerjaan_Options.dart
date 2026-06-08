import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Renovasi/Models/Renovasi_OpsiPilih.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<RenovasiOpsipilih> pengerjaanOptions = [
  RenovasiOpsipilih(
    value: "borongan",
    title: "Borongan",
    desc:
        "Harga dihitung berdasarkan total pekerjaan yang disepakati diawal. Cocok untuk pekerja dengan scope yang sudah jelas.",
    icon: FaIcon(FontAwesomeIcons.toolbox, size: 24, color: Color(0xff003466)),
  ),
  RenovasiOpsipilih(
    value: "harian",
    title: "Harian",
    desc:
        "Biaya dihitung berdasarkan jumlah hari kerja selama pengerjaan. Cocok untuk pekerjaan yang fleksibel atau masih bisa berubah",
    icon: Icon(Icons.calendar_today, size: 24, color: Color(0xff003466)),
  ),
];
