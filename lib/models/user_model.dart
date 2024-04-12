class User {
  User({required this.userName, required this.email, required this.userImage});

  final String userName;
  final String email;
  String _password = "";
  final String userImage;

  set setPassword(String password) {
    if (password != null &&
        password.isNotEmpty &&
        password.length > 6 &&
        password.contains(RegExp(r"[0-9]"))) {
      _password = password;
    }
  }

  get getPassword {
    return _password;
  }
}
