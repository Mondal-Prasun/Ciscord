import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String _userName = "";
  bool _checking = false;
  final _fromkey = GlobalKey<FormState>();

  void onSave() async {
    if (_fromkey.currentState!.validate()) {
      _fromkey.currentState!.save();
      print(_userName);
      FirebaseAuth.instance.authStateChanges().listen((user) async {
        if (user != null) {
          print(user.uid);

          user.updateDisplayName(_userName).then((value) {
            print("done");
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
            Form(
              key: _fromkey,
              child: Column(
                children: [
                  Container(
                    //MARK:User name
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
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.yellow,
              ),
              onPressed: onSave,
              child: _checking == false
                  ? const Text("save")
                  : const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
