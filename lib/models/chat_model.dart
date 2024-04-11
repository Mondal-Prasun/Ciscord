class Chat {
  Chat({required this.message})
      : date =
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
        userId = "userID";
  final String message;
  final String date;
  final String userId;
}
