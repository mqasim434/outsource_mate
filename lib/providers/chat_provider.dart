import 'package:flutter/material.dart';
import 'package:outsource_mate/models/message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ChatProvider with ChangeNotifier{

  List<MessageModel> messages = [
    MessageModel(messageText: 'Hello'),
    MessageModel(messageText: 'Hey',isSender: false),
    MessageModel(messageText: 'How are you?'),
    MessageModel(messageText: 'Im good',isSender: false),
    MessageModel(messageText: 'What about you?',isSender: false),
    MessageModel(messageText: 'Im also good',),
    MessageModel(messageText: 'Hello'),
    MessageModel(messageText: 'Hey',isSender: false),
    MessageModel(messageText: 'How are you?'),
    MessageModel(messageText: 'Im good',isSender: false),
    MessageModel(messageText: 'What about you?',isSender: false),
    MessageModel(messageText: 'Im also good',),MessageModel(messageText: 'Hello'),
    MessageModel(messageText: 'Hey',isSender: false),
    MessageModel(messageText: 'How are you?'),
    MessageModel(messageText: 'Im good',isSender: false),
    MessageModel(messageText: 'What about you?',isSender: false),
    MessageModel(messageText: 'Im also good',),
  ];

  void sendMessage(String messageText) {
    MessageModel newMessage = MessageModel(
      messageText: messageText,
      isSender: true,
    );
    messages.add(newMessage);
    notifyListeners();
  }
}
