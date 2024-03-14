class MessageModel {
  String? messageText;
  bool isSender;

  MessageModel({
    required this.messageText,
    this.isSender = true,
  });

}
