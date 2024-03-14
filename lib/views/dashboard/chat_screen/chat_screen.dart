import 'package:flutter/material.dart';
import 'package:outsource_mate/models/message_model.dart';
import 'package:outsource_mate/providers/chat_provider.dart';
import 'package:outsource_mate/res/components/message_widget.dart';
import 'package:outsource_mate/res/components/rounded_icon_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Muhammad Qasim',
          style: TextStyle(color: Colors.black,),
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          gradient: MyColors.pinkPurpleGradient,
        ),
        child: ChangeNotifierProvider(
          create: (_) => ChatProvider(),
          child: Consumer<ChatProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: provider.messages.length,
                        itemBuilder: (context, index) {
                          int len = provider.messages.length;
                          return MessageWidget(
                            messageText: provider
                                .messages[(len - 1) - index].messageText,
                            isSender:
                                provider.messages[(len - 1) - index].isSender,
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.85,
                        child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  50,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              suffixIconConstraints:
                                  const BoxConstraints(maxHeight: 14)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          provider.sendMessage(messageController.text);
                          messageController.clear();
                        },
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: MyColors.pinkColor,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
