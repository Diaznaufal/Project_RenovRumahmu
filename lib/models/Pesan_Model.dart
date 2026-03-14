enum MessageStatus { sending, sent, delivered, read }

class ChatModel {
  final String name;
  String message;
  String time;
  final String imageUrl;
  int unreadCount;

  bool lastIsMe;

  List<MessageModel> messages;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
    this.unreadCount = 0,
    this.lastIsMe = false,
    List<MessageModel>? messages,
  }) : messages = messages ?? [];
}

class MessageModel {
  final String text;
  final bool isMe;
  String time;
  MessageStatus status;

  MessageModel({
    required this.text,
    required this.isMe,
    this.time = "",
    this.status = MessageStatus.sent,
  });
}
