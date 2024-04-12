import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _fromkey = GlobalKey<FormState>();
  String _userName = "";
  String _userEmail = "";
  String _userPassword = "";

  void onSubmit() {
    if (_fromkey.currentState!.validate()) {
      _fromkey.currentState!.save();
    }
    debugPrint(_userName);
    debugPrint(_userEmail);
    debugPrint(_userPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                child: Card(
                  color: const Color.fromARGB(32, 0, 0, 0),
                  child: Form(
                    key: _fromkey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            maxLength: 40,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(170, 255, 255, 255),
                              ),
                              helperText: "enter name",
                              helperStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return "Please enter atleast 3 charecter";
                              }
                              return null;
                            },
                            onSaved: (newValue) => _userName = newValue!,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            maxLength: 40,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "email",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(170, 255, 255, 255),
                              ),
                              helperText: "enter email",
                              helperStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3 ||
                                  !value.contains("@")) {
                                return "Please enter valid email";
                              }
                              return null;
                            },
                            onSaved: (newValue) => _userEmail = newValue!,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            maxLength: 40,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "password",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(170, 255, 255, 255),
                              ),
                              helperText: "enter password",
                              helperStyle: TextStyle(color: Colors.white),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6 ||
                                  !value.contains(
                                    RegExp(r"[0-9]"),
                                  )) {
                                return "atleast 6 charecter and one number";
                              }
                              return null;
                            },
                            onSaved: (newValue) => _userPassword = newValue!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.yellow,
                ),
                onPressed: onSubmit,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
