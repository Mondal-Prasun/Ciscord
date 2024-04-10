import 'package:ciscord/widgets/channel_tile.dart';
import 'package:flutter/material.dart';

class ChannelDrawer extends StatelessWidget {
  const ChannelDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      child: Column(
        children: [
          ChannelName(channelName: "Channel 1"),
          ChannelName(channelName: "Channel 2"),
        ],
      ),
    );
  }
}
