import 'package:ciscord/provider/channel_provider.dart';
import 'package:ciscord/widgets/channel_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChannelDrawer extends ConsumerWidget {
  const ChannelDrawer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelSet = ref.watch(channelData);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      child: ListView.builder(
        itemCount: channelSet.length,
        itemBuilder: (context, index) {
          return ChannelTile(
            channelName: channelSet[index].channelName,
            ownId: channelSet[index].id,
          );
        },
      ),
    );
  }
}
