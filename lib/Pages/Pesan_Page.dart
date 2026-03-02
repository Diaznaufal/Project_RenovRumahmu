import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Bottom_Menu.dart';
import '../models/Pesan_Model.dart';
import '../Pages/Chatdetail_Page.dart';

class PesanPage extends StatefulWidget {
  @override
  State<PesanPage> createState() => _PesanPageState();
}

class _PesanPageState extends State<PesanPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black.withAlpha(77),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pesan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Transform.translate(
                      offset: Offset(12, 0),
                      child: Icon(Icons.more_vert, size: 24),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xffEBEEF3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: "Search",
                    contentPadding: EdgeInsets.only(top: 6),
                    hintStyle: TextStyle(
                      color: Color(0xFF797B7C),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF797B7C)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              buildChatTile(
                name: "Andi Pratama",
                message: "Halo, apakah project sudah selesai?",
                time: "10.00 PM",
                imageUrl: "images/org1.jpg",
                unread: 3,
              ),
              Divider(),
              buildChatTile(
                name: "Budi Santoso",
                message: "Nanti sore kita meeting ya",
                time: "08.45 AM",
                imageUrl: "images/org3.jpg",
              ),
              Divider(),
              buildChatTile(
                name: "Sinta Rahma",
                message: "Terima kasih atas bantuannya 🙏",
                time: "Kemarin",
                imageUrl: "images/org2.jpg",
              ),
              Divider(),
              buildChatTile(
                name: "Rizky Maulana",
                message: "File sudah saya kirim lewat email",
                time: "Senin",
                imageUrl: "images/org4.jpg",
              ),
              Divider(),
              buildChatTile(
                name: "Dewi Lestari",
                message: "Oke siap, saya tunggu update selanjutnya",
                time: "12 Jan",
                imageUrl: "images/org5.jpg",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomMenu(currentIndex: 2),
    );
  }

  Widget buildChatTile({
    required String name,
    required String message,
    required String time,
    required String imageUrl,
    int unread = 0,
  }) {
    return ListTile(
      dense: true,
      title: Text(
        name,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        style: TextStyle(fontSize: 12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: AssetImage(imageUrl),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(time, style: TextStyle(fontSize: 10)),
          if (unread > 0) ...[
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Color(0xff003466),
                shape: BoxShape.circle,
              ),
              child: Text(
                unread.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        final chat = ChatModel(
          name: name,
          message: message,
          time: time,
          imageUrl: imageUrl,
          unreadCount: unread,
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChatDetailPage(chat: chat)),
        );
      },
    );
  }
}
