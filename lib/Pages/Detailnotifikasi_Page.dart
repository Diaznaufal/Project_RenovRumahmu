import 'package:flutter/material.dart';
import '../models/Notifikasi_Model.dart';

class DetailNotifPage extends StatelessWidget {
  final NotifikasiModel notif;

  const DetailNotifPage({
    super.key,
    required this.notif,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notif.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              notif.icon,
              size: 40,
              color: notif.iconBg,
            ),

            SizedBox(height: 15),



            Text(notif.subtitle),

            SizedBox(height: 20),

            Text("Time : ${notif.time}"),
          ],
        ),
      ),
    );
  }
}