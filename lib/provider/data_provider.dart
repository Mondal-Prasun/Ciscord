import 'package:ciscord/models/chat_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataProvider extends StateNotifier<List<Chat>> {
  DataProvider() : super([]);

  void getChat(
      {required String msg,
      required String channelId,
      required String userId}) {
    final Chat data = Chat(
      message: msg,
      channelId: channelId,
      userId: userId,
    );
    state = [...state, data];
  }
}

final chatData = StateNotifierProvider<DataProvider, List<Chat>>(
  (ref) => DataProvider(),
);
