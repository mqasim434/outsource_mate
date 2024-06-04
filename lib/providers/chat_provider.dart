import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/models/message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ChatProvider with ChangeNotifier{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void sendMessage(MessageModel messageModel)async{
    CollectionReference chatsCollection = firebaseFirestore.collection('chats');

    await chatsCollection.add({
      'message': messageModel.messageText,
      'senderEmail': messageModel.senderEmail,
      'receiverEmail': messageModel.receiverEmail,
      'isImage': messageModel.isImage,
      'isDocument': messageModel.isDocument,
      'timestamp': FieldValue.serverTimestamp(), // This will automatically set the timestamp to the server's time
    });
  }






}
