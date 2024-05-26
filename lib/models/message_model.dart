class MessageModel {
  String? messageText;
  bool isSender;
  String senderEmail;
  String receiverEmail;
  bool isDocument;
  bool isImage;

  MessageModel({
    required this.messageText,
    required this.senderEmail,
    required this.receiverEmail,
    this.isDocument = false,
    this.isImage = false,
    this.isSender = true,
  });

}
