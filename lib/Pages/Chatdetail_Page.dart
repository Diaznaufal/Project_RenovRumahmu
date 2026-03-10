import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Attachment_Menu.dart';
import '../models/Pesan_Model.dart';
import 'dart:math' as math;

class ChatDetailPage extends StatefulWidget {
  final ChatModel chat;

  const ChatDetailPage({super.key, required this.chat});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController controller = TextEditingController();

  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();

    messages.add(MessageModel(text: widget.chat.message, isMe: false));
  }

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      messages.add(MessageModel(text: controller.text, isMe: true));
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black.withAlpha(77),
        titleSpacing: 15,
        toolbarHeight: 60,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.chat.imageUrl),
              radius: 17,
            ),
            SizedBox(width: 10),
            Text(widget.chat.name, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  return Align(
                    alignment: message.isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: message.isMe
                            ? Color(0xff003466)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isMe ? Colors.white : Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xff003466),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.add, color: Colors.white, size: 20),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return AttachmentMenu();
                          },
                        );
                      },
                    ),
                  ),

                  SizedBox(width: 8),

                  Expanded(
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 3,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: "Tulis pesan...",
                        hintStyle: TextStyle(fontSize: 13),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xff003466),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Transform.rotate(
                        angle: -math.pi / 8,
                        child: Icon(Icons.send, color: Colors.white, size: 18),
                      ),
                      onPressed: sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
