import 'package:ciscord/provider/data_provider.dart';
import 'package:ciscord/widgets/chat_bubble.dart';

import 'package:ciscord/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    required this.channelName,
    required this.channelId,
    required this.userId,
    required this.userName,
    required this.userImage,
  });
  final String channelName;
  final String channelId;
  final String userId;
  final String userName;
  final String userImage;
  @override
  ConsumerState<ChatScreen> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _fromKey = GlobalKey<FormState>();
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    void submit() {
      if (_fromKey.currentState!.validate()) {
        _fromKey.currentState!.save();
      }
      // ref.watch(chatData.notifier).loadChats(widget.channelId);

      ref.read(chatData.notifier).sendChat(
            msg: _msg,
            channelId: widget.channelId,
            userId: widget.userId,
            userName: widget.userName,
            userImage: widget.userImage,
          );

      _fromKey.currentState!.reset();
      FocusScope.of(context).unfocus();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Colors.white,
        title: Text(widget.channelName),
        actions: [
          IconButton(
            onPressed: () async {
              Clipboard.setData(
                ClipboardData(text: widget.channelId),
              ).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Channel id Coppied")),
                );
              });
            },
            icon: const Icon(Icons.copy),
          ),
        ],
      ),
      drawer: const ChannelDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 80,
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("channel_${widget.channelId}")
                  .orderBy("createdAt", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No message found",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      imgUrl: snapshot.data!.docs.toList()[index]["userImage"],
                      msg:
                          snapshot.data!.docs.toList()[index]["msg"].toString(),
                      date: snapshot.data!.docs
                          .toList()[index]["createdAt"]
                          .toString(),
                      userName: snapshot.data!.docs.toList()[index]["userName"],
                    );
                  },
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  //MARK:send Image
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 5,
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      alignment: Alignment.center,
                      //MARK:form work
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          key: _fromKey,
                          child: TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter message"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter something";
                              }
                              return null;
                            },
                            onSaved: (newValue) => _msg = newValue!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //MARK:send chat
                  IconButton(
                    onPressed: submit,
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
