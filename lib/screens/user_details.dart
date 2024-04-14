import 'dart:io';

import 'package:ciscord/screens/default_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String _userName = "";
  bool _checking = false;
  final _fromkey = GlobalKey<FormState>();
  File? _userImage;

  void onSave() async {
    if (_fromkey.currentState!.validate()) {
      _fromkey.currentState!.save();
      print(_userName);
      FirebaseAuth.instance.authStateChanges().listen((user) async {
        if (user != null) {
          print(user.uid);

          await user.updateDisplayName(_userName);
          //save image

          final storageRef = FirebaseStorage.instance.ref();
          final userImageref = storageRef.child("images/${user.uid}/userImage");

          userImageref.putFile(_userImage!).then((p0) {
            setState(() {
              _checking = true;
            });

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const DefaultScreen(),
              ),
            );
          }).onError((error, stackTrace) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Somthing went wrong"),
              ),
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User not found"),
            ),
          );
        }
      });
    }
  }

  Widget ciculerAvatar = Image.asset("lib/assets/avatar.png");

  void pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    print(image);
    if (image != null) {
      _userImage = File(image.path);
      // print(_userImage!.path);
      setState(
        () {
          ciculerAvatar = Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(60),
              ),
            ),
            child: Image.file(
              width: double.infinity,
              height: double.infinity,
              _userImage!,
              fit: BoxFit.fill,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: CircleAvatar(
                radius: 60,
                child: ciculerAvatar,
              ),
            ),
            TextButton(
              onPressed: pickImage,
              child: const Text("Choose image"),
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
