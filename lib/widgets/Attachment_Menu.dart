import 'package:flutter/material.dart';

class AttachmentMenu extends StatelessWidget {
  const AttachmentMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// drag handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: Icon(Icons.camera_alt, size: 20),
            title: Text("Kamera"),
            onTap: () {},
          ),

          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: Icon(Icons.photo, size: 20),
            title: Text("Galeri"),
            onTap: () {},
          ),

          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: Icon(Icons.insert_drive_file, size: 20),
            title: Text("Dokumen"),
            onTap: () {},
          ),

          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: Icon(Icons.location_on, size: 20),
            title: Text("Lokasi"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
