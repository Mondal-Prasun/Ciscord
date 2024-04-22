import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Chat {
  Chat({
    required this.message,
    required this.channelId,
    required this.userId,
    required this.userName,
    required this.userImage,
  })  : createdAt = Timestamp.now().toDate().toString(),
        postId = const Uuid().v4();
  final String message;
  final String createdAt;
  final String userName;
  final String userImage;
  final String userId;
  final String channelId;

  String postId;
}
