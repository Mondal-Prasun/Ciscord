import 'package:ciscord/models/chat_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseApp = Firebase.app();
final rtdb = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL:
        'https://ciscord-74ece-default-rtdb.asia-southeast1.firebasedatabase.app/');

class DataProvider extends StateNotifier<List<Chat>> {
  DataProvider() : super([]);

  void getChat(
      {required String msg,
      required String channelId,
      required String userId,
      required String userName}) {
    final Chat data = Chat(
        message: msg, channelId: channelId, userId: userId, userName: userName);
    state = [...state, data];
  }
}

final chatData = StateNotifierProvider<DataProvider, List<Chat>>(
  (ref) => DataProvider(),
);
