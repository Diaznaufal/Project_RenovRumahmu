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

  List<ChatModel> chats = [
    ChatModel(
      name: "Andi Pratama",
      message: "Halo, apakah project sudah selesai?",
      time: "10.00 PM",
      imageUrl: "images/org1.jpg",
      unreadCount: 3,
    ),
    ChatModel(
      name: "Budi Santoso",
      message: "Nanti sore kita meeting ya",
      time: "08.45 AM",
      imageUrl: "images/org3.jpg",
    ),
    ChatModel(
      name: "Sinta Rahma",
      message: "Terima kasih atas bantuannya 🙏",
      time: "Kemarin",
      imageUrl: "images/org2.jpg",
    ),
    ChatModel(
      name: "Rizky Maulana",
      message: "File sudah saya kirim lewat email",
      time: "Senin",
      imageUrl: "images/org4.jpg",
    ),
    ChatModel(
      name: "Dewi Lestari",
      message: "Oke siap, saya tunggu update selanjutnya",
      time: "12 Jan",
      imageUrl: "images/org5.jpg",
    ),
  ];

  Widget buildStatusIcon(bool isMe, int unread) {
    if (!isMe) return SizedBox();

    if (unread > 0) {
      return Icon(Icons.check, size: 14, color: Colors.grey);
    } else {
      return Icon(Icons.done_all, size: 14, color: Colors.blue);
    }
  }

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
                  Icon(Icons.more_vert),
                ],
              ),
              SizedBox(height: 10),
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
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];

          return Column(
            children: [
              ListTile(
                dense: true,

                title: Text(
                  chat.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),

                subtitle: Text(
                  chat.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),

                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(chat.imageUrl),
                ),

                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildStatusIcon(chat.lastIsMe, chat.unreadCount),

                        if (chat.lastIsMe) SizedBox(width: 4),

                        Text(chat.time, style: TextStyle(fontSize: 10)),
                      ],
                    ),

                    if (chat.unreadCount > 0)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xff003466),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          chat.unreadCount.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),

                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailPage(chat: chat),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      chat.message = result["message"];
                      chat.time = result["time"];
                      chat.lastIsMe = result["isMe"];
                      chat.unreadCount = 0;

                      final updated = chats.removeAt(index);
                      chats.insert(0, updated);
                    });
                  }
                },
              ),

              Divider(),
            ],
          );
        },
      ),

      bottomNavigationBar: BottomMenu(currentIndex: 2),
    );
  }
}
