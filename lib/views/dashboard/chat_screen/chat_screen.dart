import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outsource_mate/models/message_model.dart';
import 'package:outsource_mate/models/user_model.dart';
import 'package:outsource_mate/providers/chat_provider.dart';
import 'package:outsource_mate/providers/user_provider.dart';
import 'package:outsource_mate/res/components/message_widget.dart';
import 'package:outsource_mate/res/components/rounded_rectangular_button.dart';
import 'package:outsource_mate/res/myColors.dart';
import 'package:outsource_mate/utils/utility_functions.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, this.otherUser});

  final dynamic otherUser;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final chatProvider = Provider.of<ChatProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    TextEditingController messageController = TextEditingController();

    userProvider.updateUserField(fieldName: 'isOnline', newValue: true);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            userProvider.updateUserField(fieldName: 'isOnline', newValue: false);
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              otherUser.email.toString(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(UtilityFunctions.getCollectionName(otherUser.userType))
                  .where('email', isEqualTo: otherUser.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return const Text('No Data');
                }else if(snapshot.connectionState==ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }else{
                  bool isTyping = snapshot.data!.docs.first.data()['isTyping'];
                  return Text(
                    isTyping?'typing...':'',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  );
                }
              }
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: ChangeNotifierProvider(
        create: (_) => ChatProvider(),
        child: Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chat')
                        .doc('gMlFQdxujngu2REpnGTJ')
                        .collection('freelancerClientChat')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (!snapshot.hasData) {
                        return const Center(
                          child: Text('No Messages Yet!'),
                        );
                      } else {
                        var messages = snapshot.data!.docs.toList();
                        return ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = messages[index];
                              // DateTime dateTime = message['timestamp'].toDate();
                              // DateFormat timeFormat = DateFormat.jm();
                              // String timeString = timeFormat.format(dateTime);
                              return MessageWidget(
                                messageText: message['message'],
                                // time: message['timestamp'].toDate().toString().split(' ')[1].split('.')[0],
                                isSender: UserModel.currentUser.email ==
                                    message['senderEmail'],
                                time: 'timeString',
                              );
                            });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.85,
                        child: TextFormField(
                          controller: messageController,
                          onChanged: (value) {
                            userProvider.updateUserField(
                                fieldName: 'isTyping', newValue: true);
                          },
                          onEditingComplete: () {
                            userProvider.updateUserField(
                                fieldName: 'isTyping', newValue: false);
                          },
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            suffixIcon: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Choose an option'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                ImagePicker picker =
                                                    ImagePicker();
                                                XFile? pickedFile =
                                                    await picker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                Navigator.pop(context);
                                                if (pickedFile != null) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Image Preview'),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Image.file(File(
                                                                  pickedFile
                                                                      .path)),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              RoundedRectangularButton(
                                                                buttonText:
                                                                    'Send',
                                                                onPress: () {
                                                                  MessageModel
                                                                      messageModel =
                                                                      MessageModel(
                                                                    messageText:
                                                                        messageController
                                                                            .text,
                                                                    senderEmail:
                                                                        UserModel
                                                                            .currentUser
                                                                            .email,
                                                                    receiverEmail:
                                                                    otherUser.email
                                                                            .toString(),
                                                                  );
                                                                  // chatProvider.sendMessage();
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                }
                                              },
                                              child: const ListTile(
                                                title: Text('Camera'),
                                                leading: Icon(Icons.camera_alt),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                ImagePicker picker =
                                                    ImagePicker();
                                                XFile? pickedFile =
                                                    await picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                Navigator.pop(context);
                                                if (pickedFile != null) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Image Preview'),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Image.file(File(
                                                                  pickedFile
                                                                      .path)),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              RoundedRectangularButton(
                                                                buttonText:
                                                                    'Send',
                                                                onPress:
                                                                    () async {
                                                                  print(
                                                                      'Send Button Clicked');
                                                                  String
                                                                      downloadUrl =
                                                                      await uploadFileToFirebaseStorage(
                                                                          pickedFile
                                                                              .path);
                                                                  MessageModel
                                                                      messageModel =
                                                                      MessageModel(
                                                                    messageText:
                                                                        downloadUrl,
                                                                    senderEmail:
                                                                        UserModel
                                                                            .currentUser
                                                                            .email,
                                                                    receiverEmail:
                                                                    otherUser.email
                                                                            .toString(),
                                                                    isImage:
                                                                        true,
                                                                  );
                                                                  chatProvider
                                                                      .sendMessage(
                                                                          messageModel);
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                }
                                              },
                                              child: const ListTile(
                                                title: Text('Gallery'),
                                                leading: Icon(Icons.camera),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: const Icon(
                                Icons.attach_file,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          userProvider.updateUserField(
                              fieldName: 'isTyping', newValue: false);
                          if (messageController.text.isNotEmpty) {
                            MessageModel messageModel = MessageModel(
                              messageText: messageController.text,
                              senderEmail: UserModel.currentUser.email,
                              receiverEmail: otherUser.email.toString(),
                            );
                            chatProvider.sendMessage(messageModel);
                            messageController.clear();
                          }
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  TimeOfDay convertStringToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<String> uploadFileToFirebaseStorage(String filePath) async {
    print('Uploading file');
    EasyLoading.show(status: 'Uploading File');
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chat_files')
        .child(DateTime.now().millisecondsSinceEpoch.toString());
    final UploadTask uploadTask = storageReference.putFile(File(filePath));

    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    EasyLoading.dismiss();
    return downloadUrl;
  }
}
