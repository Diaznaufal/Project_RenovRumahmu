import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Remote/Renovasi_Form/Area_Options.dart';
import 'package:flutter_application_1/Data/Remote/Renovasi_Form/Kebutuhan_Options.dart';
import 'package:flutter_application_1/Data/Remote/Renovasi_Form/Pekerjaan_Options.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import 'package:flutter_application_1/Features/Renovasi/Models/Renovasi_Model.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class RenovasiPerbaikan extends StatefulWidget {
  @override
  State<RenovasiPerbaikan> createState() => _RenovasiPerbaikanState();
}

class _RenovasiPerbaikanState extends State<RenovasiPerbaikan> {
  RenovasiModel formData = RenovasiModel();
  @override
  Widget build(BuildContext context) {
    final prov = context.watch<RenovasiProvider>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Apa Kebutuhan Anda?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Inria Sans",
              ),
            ),
            Column(
              children: kebutuhanOptions.map((item) {
                final isSelected = prov.formData.kebutuhan == item.value;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 220),
                  curve: Curves.easeInOut,

                  margin: EdgeInsets.only(top: 12),

                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xff045097).withAlpha(10)
                        : Colors.white,

                    borderRadius: BorderRadius.circular(10),

                    border: Border.all(
                      color: isSelected
                          ? Color(0xff045097)
                          : Colors.grey.shade300,
                      width: 1.3,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Material(
                    color: Colors.transparent,

                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),

                      onTap: () => prov.setKebutuhan(item.value),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Color(0xff045097)
                                          : Colors.black,
                                      fontFamily: "Inria Sans",
                                    ),
                                  ),

                                  if (item.desc != null) ...[
                                    Text(
                                      item.desc!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700,
                                        fontFamily: "Inria Sans",
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),

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
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 15),
            Text(
              "Area/Bagian yang dikerjakan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Inria Sans",
              ),
            ),

            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: DropdownButtonFormField2<String>(
                isExpanded: true,

                value: prov.formData.area,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,

                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.black87, width: 1.5),
                  ),
                ),

                hint: Text(
                  'Pilih area',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                ),

                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black87,
                  ),
                  iconSize: 26,
                ),

                dropdownStyleData: DropdownStyleData(
                  maxHeight: 155,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                  ),

                  elevation: 4,
                ),

                menuItemStyleData: MenuItemStyleData(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),

                items: areaOptions.map((item) {
                  print(prov.formData.area);
                  return DropdownMenuItem<String>(
                    value: item.value,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.5),
                        ),
                      ),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),

                selectedItemBuilder: (context) {
                  return areaOptions.map((item) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList();
                },

                onChanged: (value) {
                  if (value != null) {
                    prov.setArea(value);
                  }
                },
              ),
            ),

            SizedBox(height: 16),
            Text(
              "Tingkat Pekerjaan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Inria Sans",
              ),
            ),
            Column(
              children: pekerjaanOptions.map((item) {
                final isSelected = prov.formData.tingkatKerusakan == item.value;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 220),
                  curve: Curves.easeInOut,

                  margin: EdgeInsets.only(top: 12),

                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xff045097).withAlpha(10)
                        : Colors.white,

                    borderRadius: BorderRadius.circular(10),

                    border: Border.all(
                      color: isSelected
                          ? Color(0xff045097)
                          : Colors.grey.shade300,
                      width: 1.3,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Material(
                    color: Colors.transparent,

                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),

                      onTap: () => prov.setTingkat(item.value),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Color(0xff045097)
                                          : Colors.black,
                                      fontFamily: "Inria Sans",
                                    ),
                                  ),

                                  if (item.desc != null) ...[
                                    Text(
                                      item.desc!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700,
                                        fontFamily: "Inria Sans",
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),

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
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
