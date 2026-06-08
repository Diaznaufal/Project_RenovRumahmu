import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Remote/Renovasi_Form/Pengerjaan_Options.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import 'package:provider/provider.dart';
import '../Models/Renovasi_Model.dart';
import 'package:intl/intl.dart';

class JadwalPreferensi extends StatefulWidget {
  @override
  State<JadwalPreferensi> createState() => _JadwalPreferensiState();
}

class _JadwalPreferensiState extends State<JadwalPreferensi> {
  late TextEditingController catatanController;
  RenovasiModel formData = RenovasiModel();
  final tanggalController = TextEditingController();
  final jamController = TextEditingController();

  Future<void> pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff045097),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      tanggalController.text = DateFormat('dd - MM - yyyy').format(picked);

      context.read<RenovasiProvider>().setTanggal(picked);
    }
  }

  Future<void> pilihJam() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xff044097),
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: Colors.white,
                hourMinuteTextColor: Colors.black,
                dayPeriodTextColor: Colors.black,
                dialHandColor: Color(0xff045097),
                dialBackgroundColor: Color(0xfff3f6fa),
                hourMinuteColor: Color(0xffEAF2FB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(24),
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) {
      final jam =
          "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";

      jamController.text = jam;

      context.read<RenovasiProvider>().setJam(jam);
    }
  }

  @override
  void initState() {
    super.initState();
    final prov = Provider.of<RenovasiProvider>(context, listen: false);

    catatanController = TextEditingController(
      text: prov.formData.catatanLokasi ?? "",
    );
  }

  @override
  void dispose() {
    catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<RenovasiProvider>();
    if (prov.formData.tanggalKunjungan != null &&
        tanggalController.text.isEmpty) {
      tanggalController.text = DateFormat(
        "dd - MM - yyyy",
      ).format(prov.formData.tanggalKunjungan!);
    }
    if (prov.formData.jamKunjungan != null && jamController.text.isEmpty) {
      jamController.text = prov.formData.jamKunjungan!;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Jadwal Kunjungan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Center(
                          child: TextFormField(
                            controller: tanggalController,
                            readOnly: true,
                            onTap: pilihTanggal,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Inria Sans",
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              hintText: "Tanggal Kunjungan",
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: "Inria Sans",
                              ),
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Color(0xff003466),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Center(
                          child: TextFormField(
                            controller: jamController,
                            readOnly: true,
                            onTap: pilihJam,
                            textAlign: TextAlign.center,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Inria Sans",
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              hintText: "Jam Kunjungan",
                              hintStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: "Inria Sans",
                              ),
                              suffixIcon: Icon(
                                Icons.access_time,
                                size: 20,
                                color: Color(0xff003466),
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Catatan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),

                decoration: BoxDecoration(
                  color: Color(0xffF7F8FA),

                  borderRadius: BorderRadius.circular(10),

                  border: Border.all(color: Colors.grey.shade200, width: 1),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(6),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),

                child: TextField(
                  controller: catatanController,

                  onChanged: (value) {
                    context.read<RenovasiProvider>().setCatatan(value);
                  },

                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: "Inria Sans",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),

                  decoration: InputDecoration(
                    isCollapsed: true,

                    border: InputBorder.none,

                    hintText:
                        "Contoh: akses gang sempit, pagar warna hitam (optional)",

                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontFamily: "Inria Sans",
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Metode Pengerjaan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: pengerjaanOptions.map((item) {
                  final isSelected = prov.formData.pengerjaan == item.value;

                  return InkWell(
                    onTap: () => prov.setPengerjaan(item.value),

                    borderRadius: BorderRadius.circular(16),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,

                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 220),

                      margin: EdgeInsets.only(top: 12),

                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),

                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color(0xff045097).withAlpha(12)
                            : Colors.white,

                        borderRadius: BorderRadius.circular(16),

                        border: Border.all(
                          color: isSelected
                              ? Color(0xff045097)
                              : Colors.grey.shade300,
                          width: 1.2,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(8),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          // ICON
                          if (item.icon != null)
                            Container(
                              width: 35,
                              height: 35,

                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color(0xff045097).withAlpha(18)
                                    : Colors.grey.shade100,

                                borderRadius: BorderRadius.circular(14),
                              ),

                              child: Center(
                                child: IconTheme(
                                  data: IconThemeData(
                                    color: isSelected
                                        ? Color(0xff045097)
                                        : Colors.black87,
                                    size: 24,
                                  ),

                                  child: item.icon!,
                                ),
                              ),
                            ),

                          if (item.icon != null) SizedBox(width: 14),

                          // TEXT
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  item.title,

                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,

                                    color: isSelected
                                        ? Color(0xff045097)
                                        : Colors.black87,

                                    fontFamily: "Inria Sans",
                                  ),
                                ),

                                if (item.desc != null) ...[
                                  SizedBox(height: 6),

                                  Text(
                                    item.desc!,

                                    style: TextStyle(
                                      fontSize: 13,
                                      height: 1.5,

                                      color: Colors.grey.shade700,

                                      fontFamily: "Inria Sans",
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          SizedBox(width: 12),

                          // CUSTOM RADIO
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),

                            width: 22,
                            height: 22,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              color: isSelected
                                  ? Color(0xff045097)
                                  : Colors.transparent,

                              border: Border.all(
                                color: isSelected
                                    ? Color(0xff045097)
                                    : Colors.grey.shade500,
                                width: 1.7,
                              ),
                            ),

                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
