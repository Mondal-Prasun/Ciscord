import 'package:ciscord/models/channel_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Channel> test = [
  Channel(channelName: "First channel", description: "some description1"),
  Channel(channelName: "Second Channel", description: "some desciption 2")
];

class ChannelProvider extends StateNotifier<List<Channel>> {
  ChannelProvider()
      : super([
          ...test,
        ]);

  void addChannel(String channelName, String desciption) {
    final Channel channel =
        Channel(channelName: channelName, description: desciption);
    state = [...state, channel];
  }

  void addChannelDirect(Channel channel) {
    state = [...state, channel];
  }
}

final channelData = StateNotifierProvider<ChannelProvider, List<Channel>>(
  (ref) => ChannelProvider(),
);
