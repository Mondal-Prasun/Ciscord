import 'package:ciscord/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class ChannelTile extends StatelessWidget {
  const ChannelTile({
    super.key,
    required this.channelName,
    required this.ownId,
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  final String channelName;
  final String ownId;
  final String userId;
  final String userName;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              channelName: channelName,
              channelId: ownId,
              userId: userId,
              userName: userName,
              userImage: userImage,
            ),
          ),
        );
      },
      child: Card(
        color: const Color.fromARGB(21, 0, 0, 0),
        child: ListTile(
          title: Text(
            channelName,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
