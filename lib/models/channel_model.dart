import 'package:uuid/uuid.dart';

class Channel {
  Channel({required this.channelName, required this.description})
      : id = const Uuid().v4();

  final String channelName;
  final String description;
  final String id;
}
