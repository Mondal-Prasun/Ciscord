import 'package:ciscord/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataProvider extends StateNotifier<List<Chat>> {
  DataProvider() : super([]);

  void sendChat(
      {required String msg,
      required String channelId,
      required String userId,
      required String userName,
      required String userImage}) async {
    final Chat data = Chat(
        message: msg,
        channelId: channelId,
        userId: userId,
        userName: userName,
        userImage: userImage);

    await FirebaseFirestore.instance
        .collection("channel_${data.channelId}")
        .add({
      "createdAt": data.createdAt,
      "msg": data.message,
      "channelId": data.channelId,
      "userId": data.userId,
      "userName": data.userName,
      "userImage": data.userImage,
      "postId": data.postId,
    });

    print("done");
  }
}

final chatData = StateNotifierProvider<DataProvider, List<Chat>>(
  (ref) => DataProvider(),
);
