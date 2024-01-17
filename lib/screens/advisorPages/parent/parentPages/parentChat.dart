import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/chatModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/services/chatDatabase.dart';
import 'package:ummicare/services/notificationDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/services/storage.dart';

class parentChat extends StatefulWidget {
  const parentChat({super.key, required this.parentId});
  final String parentId;

  @override
  State<parentChat> createState() => _parentChatState();
}

class _parentChatState extends State<parentChat> {
  late File imageFile;
  String imageUrl = '';
  String chatId = '';
  String advisorId = '';
  String parentId = '';
  List<messageModel> listMessage = [];

  int _limit = 20;
  int _limitIncrement = 20;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit <= listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  _scrollToEnd(int time) async {
    listScrollController.animateTo(
        listScrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: time),
        curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<parentModel>(
      stream: parentDatabase(parentId: widget.parentId).parentData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          parentModel? parent = snapshot.data;
          chatId = '${parent!.advisorId}${parent.parentId}';
          advisorId = parent.advisorId;
          parentId = parent.parentId;
          return Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: 'Parent',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/advisor/parent');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                            text: parent.parentFirstName,
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/advisor/parent/${parent.parentId}');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: const TextSpan(
                          text: 'Chat',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      parent.parentFullName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 45.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      parent.parentEmail,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                      constraints: const BoxConstraints(
                          maxHeight: 600, maxWidth: double.maxFinite),
                      child: buildChat())
                  // SizedBox(
                  //   height: 800,
                  //   width: 1000,
                  //   child: SingleChildScrollView(
                  //     child: Column(
                  //         children: <Widget>[buildListMessage(), buildInput()],
                  //       ),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildChat() {
    _scrollToEnd(1);
    return Column(
      children: <Widget>[buildListMessage(), buildInput()],
    );
  }

  Widget buildItem(int index, messageModel message) {
    if (message.senderId == advisorId) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          message.type == 'text'
              ? Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 300,
                  decoration: BoxDecoration(
                      color: const Color(0xff71CBCA),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    message.content,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                      color: const Color(0xff71CBCA),
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => viewChatImage(
                      //           imageLink: message.content),
                      //     ));
                    },
                    child: ImageNetwork(
                      image: message.content,
                      height: 400,
                      width: 400,
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
        ],
      );
    } else if (message.senderId == parentId) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          message.type == 'text'
              ? Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(0xff8290F0),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    message.content,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                      color: const Color(0xff8290F0),
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => viewChatImage(
                      //           imageLink: message.content),
                      //     ));
                    },
                    child: ImageNetwork(
                      image: message.content,
                      height: 400,
                      width: 400,
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder<List<messageModel>>(
        stream: chatDatabase(chatId: chatId).allMessages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<messageModel>? listMessages = snapshot.data;
            if (listMessages!.length > 0) {
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) =>
                    buildItem(index, listMessages.elementAt(index)),
                itemCount: listMessages.length,
                reverse: false,
                controller: listScrollController,
              );
            } else {
              return const Center(
                child: Text('No message here yet....'),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildInput() {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: getImage,
            color: Colors.black,
          ),
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 'text');
                },
                style: const TextStyle(color: Colors.black, fontSize: 15),
                controller: textEditingController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                autofocus: true,
                focusNode: focusNode,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              onSendMessage(textEditingController.text, 'text');
            },
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      String imageURL = await StorageService().uploadChatImage(pickedFile);
      onSendMessage(imageURL, 'image');
    }
  }

  void onSendMessage(String content, String type) {
    if (content != '') {
      textEditingController.clear();
      chatDatabase(chatId: chatId).updateMessageData(
          DateTime.now().millisecondsSinceEpoch.toString(),
          advisorId,
          parentId,
          content,
          type);
      notificationDatabase().createNotificationData(
          parentId,
          '',
          'chat',
          'Message from Advisor',
          content,
          'unseen',
          DateTime.now().millisecondsSinceEpoch.toString());
      if (listScrollController.hasClients) {
        _scrollToEnd(3000);
      }
    } else {}
  }
}
