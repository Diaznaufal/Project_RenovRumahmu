class ChatModel {
  final String name;
  String message;
  String time;
  final String imageUrl;
  int unreadCount;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
    this.unreadCount = 0,
  });
}

class MessageModel {
  final String text;
  final bool isMe;

  MessageModel({required this.text, required this.isMe});
}
