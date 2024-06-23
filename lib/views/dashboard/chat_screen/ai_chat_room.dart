import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:outsource_mate/models/user_model.dart';

class AiChatRoom extends StatefulWidget {
  const AiChatRoom({super.key});

  @override
  State<AiChatRoom> createState() => _AiChatRoomState();
}

class _AiChatRoomState extends State<AiChatRoom> {
  ChatUser currentUser = ChatUser(
    id: '0',
    firstName: UserModel.currentUser.name.toString(),
  );
  ChatUser geminiUser = ChatUser(
    id: '1',
    firstName: 'MateBot',
  );

  final Gemini gemini = Gemini.instance;

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      chatMessages = [chatMessage, ...chatMessages];
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = chatMessages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = chatMessages.removeAt(0);
          String? response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";
          lastMessage.text = response;
          setState(() {
            chatMessages = [lastMessage!, ...chatMessages];
          });
        } else {
          String responce = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: responce);
          setState(() {
            chatMessages = [message, ...chatMessages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  List<ChatMessage> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Ai Chat Room',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: DashChat(
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: chatMessages,
      ),
    ));
  }
}
