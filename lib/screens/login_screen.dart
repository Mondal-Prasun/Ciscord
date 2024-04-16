import 'package:ciscord/screens/default_screen.dart';
import 'package:ciscord/screens/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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

  String _userEmail = "";
  String _userPassword = "";
  bool _isUser = false;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        return;
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DefaultScreen(),
          ),
        );
      }
    });
  }

//MARK: auth method
  void onSubmit() async {
    if (_fromkey.currentState!.validate()) {
      _fromkey.currentState!.save();
      if (!_isUser) {
        setState(() {
          _checking = true;
        });

        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _userEmail,
          password: _userPassword,
        )
            .then(
          (value) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const UserDetailsScreen(),
              ),
            );
          },
        ).onError((error, stackTrace) {
          setState(() {
            _checking = false;
          });

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("email is already exsist"),
            ),
          );
        });
      } else {
        setState(() {
          _checking = true;
        });
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _userEmail, password: _userPassword)
            .then((value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const DefaultScreen(),
            ),
          );
        }).onError((error, stackTrace) {
          setState(() {
            _checking = false;
          });
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("please enter valid email and password"),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                          //MARK:user email
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
                          //MARK:user password
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
                child: _checking == false
                    ? Text(_isUser == true ? "log in" : "sign up")
                    : const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isUser == true
                        ? "create account"
                        : "already have a account",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (!_isUser) {
                          _isUser = true;
                        } else {
                          _isUser = false;
                        }
                      });
                    },
                    child: Text(_isUser == true ? "sign up" : "sign in"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
