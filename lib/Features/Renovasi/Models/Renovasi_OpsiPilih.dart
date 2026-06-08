import 'package:flutter/material.dart';

class RenovasiOpsipilih {
  final String value;
  final String title;
  final String? desc;
  final Widget? icon;

  final int price;

  RenovasiOpsipilih({
    required this.value,
    required this.title,
    this.desc,
    this.icon,
    this.price = 0,
  });
}
