import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({super.key});
  @override
  State<ChatBubble> createState() {
    return _ChatBubbleState();
  }
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.green,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Name"),
                    SizedBox(
                      width: 20,
                    ),
                    Text("date"),
                  ],
                ),
                Text("Its some message content"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
