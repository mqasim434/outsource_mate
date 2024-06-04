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

  // Convert a MessageModel instance to a Map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'messageText': messageText,
      'isSender': isSender,
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'isDocument': isDocument,
      'isImage': isImage,
    };
  }

  // Create a MessageModel instance from a Map (fromJson)
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageText: json['messageText'],
      isSender: json['isSender'],
      senderEmail: json['senderEmail'],
      receiverEmail: json['receiverEmail'],
      isDocument: json['isDocument'],
      isImage: json['isImage'],
    );
  }
}
