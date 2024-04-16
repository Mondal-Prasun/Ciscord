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

  void loadChannels() async {
    final ref = rtdb.ref();
    final snapshot = await ref.child("channels").get();
    if (snapshot.exists) {
      // print(snapshot.value);
      Map test = snapshot.value as Map;
      print(test.keys);
    }
  }

  void addChannel(String channelName, String desciption) async {
    final Channel channel =
        Channel(channelName: channelName, description: desciption);

    state = [...state, channel];
  }

  void addChannelDirect(Channel channel, String userId) async {
    final channelRef = rtdb.ref("channels/${channel.id}");

    await channelRef.set({
      "name": "${channel.channelName}",
      "description": "${channel.description}"
    });

    state = [...state, channel];
  }
}

final channelData = StateNotifierProvider<ChannelProvider, List<Channel>>(
  (ref) => ChannelProvider(),
);
