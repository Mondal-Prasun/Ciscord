import 'package:ciscord/models/chat_model.dart';
import 'package:ciscord/provider/data_provider.dart';
import 'package:ciscord/widgets/chat_bubble.dart';
import 'package:ciscord/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    required this.channelName,
    required this.channelId,
  });
  final String channelName;
  final String channelId;
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
    final List<Chat> data = ref
        .watch(chatData)
        .where((e) => e.channelId == widget.channelId)
        .toList();

    void submit() {
      if (_fromKey.currentState!.validate()) {
        _fromKey.currentState!.save();
      }

      ref
          .read(chatData.notifier)
          .getChat(msg: _msg, channelId: widget.channelId, userId: "UsedId");

      print(_msg);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Colors.white,
        title: Text(widget.channelName),
      ),
      drawer: const ChannelDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 80,
            ),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Expanded(
                  child: ChatBubble(
                    msg: data[index].message,
                    date: data[index].date,
                  ),
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
                            ),
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
