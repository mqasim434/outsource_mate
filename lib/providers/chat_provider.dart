import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outsource_mate/models/message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
    final tokenData = await FirebaseFirestore.instance
        .collection('deviceTokens')
        .where('email', isEqualTo: messageModel.receiverEmail)
        .get();

    if (tokenData.docs.isNotEmpty) {
      String token = tokenData.docs.first.data()['token'];
      var data = {
        'to': token,
        'priority': 'high',
        'notification': {
          'title': messageModel.senderEmail,
          'body': messageModel.messageText,
          'sound': 'assets/sounds/custom_sound.mp3',
        }
      };

      try {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
            'key=AAAAdXFIeUc:APA91bEtFbRX7OfO1J0FG6LD6STe3I21HXrXJUatzP_f520DWg2Z7CNzNAeXbbsRQRxCHhkyz5BTbitnAlLizw82ECOGlibYIPJzojSTcXPQ4Nk8NvksSlTMKiZB0JP-BYhrXpiX1hDR',
          },
        );
        print('Message sent successfully');
      } catch (error) {
        print('Error sending message: $error');
      }
    } else {
      print('No token found for email: ${messageModel.receiverEmail}');
    }
  }






}
