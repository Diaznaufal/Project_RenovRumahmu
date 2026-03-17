import 'package:flutter/material.dart';
import '../models/Notifikasi_Model.dart';

class NotifikasiButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const NotifikasiButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(0xfff5f9fd),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}

class notifikasiCard extends StatelessWidget {
  final NotifikasiModel notif;

  const notifikasiCard({
    super.key,
    required this.notif,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),

      decoration: BoxDecoration(
        color: notif.isRead
            ? Color(0xFFCCCCCC) // sudah dibaca
            : Color(0xFFFFFFFF),

        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),

        leading: Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: notif.iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            notif.icon,
            color: Colors.white,
            size: 26,
          ),
        ),

        title: Row(
          children: [
            Expanded(
              child: Text(
                notif.title,
                style: TextStyle(
                  fontSize: 16,

                  // unread lebih tebal
                  fontWeight: notif.isRead
                      ? FontWeight.w500
                      : FontWeight.w700,

                  color: Colors.black,
                ),
              ),
            ),

            // waktu
            Text(
              notif.time,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        subtitle: Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            notif.subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}