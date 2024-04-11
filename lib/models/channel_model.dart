import 'package:ciscord/models/user_model.dart';
import 'package:uuid/uuid.dart';

class Channel {
  Channel({required this.channelName})
      : id = const Uuid().v4(),
        users = [];

  final String channelName;
  final String id;
  final List<User> users;
}
