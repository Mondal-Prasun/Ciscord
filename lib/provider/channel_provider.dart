import 'package:ciscord/models/channel_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Channel> test = [
  Channel(channelName: "First channel"),
  Channel(channelName: "Second Channel")
];

class ChannelProvider extends StateNotifier<List<Channel>> {
  ChannelProvider()
      : super([
          ...test,
        ]);

  void addChannel(String channelName) {
    final Channel channel = Channel(channelName: channelName);
    state = [...state, channel];
  }
}

final channelData = StateNotifierProvider<ChannelProvider, List<Channel>>(
  (ref) => ChannelProvider(),
);
