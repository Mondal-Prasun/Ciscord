import 'package:ciscord/models/channel_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseApp = Firebase.app();
final rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL:
        'https://ciscord-74ece-default-rtdb.asia-southeast1.firebasedatabase.app/');

class ChannelProvider extends StateNotifier<List<Channel>> {
  ChannelProvider() : super([]);

  void loadChannels(String userId) async {
    List<Channel> userAddedChannels = [];

    final userChannelRef = rtdb.ref("users/$userId/userChannels");
    userChannelRef.onValue.listen((event1) {
      for (final channel in event1.snapshot.children) {
        final value = channel.value as Map;
        final channelRef = rtdb.ref("channels/${value["channelId"]}");
        channelRef.onValue.listen((event2) {
          final channelValue = event2.snapshot.value as Map;
          final gainedChannel = Channel(
              channelName: channelValue["name"],
              description: channelValue["description"])
            ..id = value["channelId"];

          if (userAddedChannels.isEmpty) {
            userAddedChannels.add(gainedChannel);
          } else {
            for (final e in userAddedChannels) {
              if (e.id != value["channelId"]) {
                userAddedChannels.add(gainedChannel);
              }
            }
          }

          if (userAddedChannels.isNotEmpty) {
            state = userAddedChannels;
          }
        });
      }
    });
  }

  void addChannel(String channelName, String desciption) async {
    final Channel channel =
        Channel(channelName: channelName, description: desciption);

    state = [...state, channel];
  }

  Future<bool> addChannelDirect(Channel channel, String userId) async {
    try {
      final channelRef = rtdb.ref("channels/${channel.id}");

      await channelRef.set({
        "name": "${channel.channelName}",
        "description": "${channel.description}",
      });

      final userRef = rtdb.ref("users/$userId/userChannels");
      final userChannelref = userRef.push();
      await userChannelref.set({
        "channelId": channel.id,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}

final channelData = StateNotifierProvider<ChannelProvider, List<Channel>>(
  (ref) => ChannelProvider(),
);
