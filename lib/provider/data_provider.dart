import 'package:ciscord/models/chat_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataProvider extends StateNotifier<List<Chat>> {
  DataProvider() : super([]);

  void getChat(String msg) {
    final Chat data = Chat(message: msg);
    state = [...state, data];
  }
}

final chatData = StateNotifierProvider<DataProvider, List<Chat>>(
  (ref) => DataProvider(),
);
