import 'package:ciscord/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ChannelName extends StatelessWidget {
  const ChannelName({super.key, required this.channelName});

  final String channelName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ChatScreen(channelName: channelName),
          ),
        );
      },
      child: ListTile(
        title: Text(
          channelName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
