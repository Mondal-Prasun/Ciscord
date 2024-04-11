final currentDate = DateTime.now();

class Chat {
  Chat({required this.message})
      : date = "${currentDate.day}/${currentDate.month}/${currentDate.year}",
        userId = "userID";
  final String message;
  final String date;
  final String userId;
}
