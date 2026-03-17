import 'package:flutter/material.dart';

class NotifikasiModel {
  final String id;
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String time;

  bool isRead;

  NotifikasiModel({
    required this.id,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isRead,
  });
}