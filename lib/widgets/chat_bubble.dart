import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble(
      {super.key,
      required this.imgUrl,
      required this.msg,
      required this.date,
      required this.userName});
  final String msg;
  final String date;
  final String userName;
  final String imgUrl;
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
          CircleAvatar(
            child: Image(image: NetworkImage(widget.imgUrl)),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.date,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.msg,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
