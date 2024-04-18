class Chat {
  Chat({
    required this.message,
    required this.channelId,
    required this.userId,
    required this.userName,
  }) : date =
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
  final String message;
  final String date;
  final String userName;
  final String userId;
  final String channelId;
}
