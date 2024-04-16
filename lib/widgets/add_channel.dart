import 'package:ciscord/models/channel_model.dart';
import 'package:flutter/material.dart';

class AddChannel extends StatelessWidget {
  const AddChannel({super.key});

  @override
  Widget build(BuildContext context) {
    final _fromkey = GlobalKey<FormState>();

    String? _channelName;

    String? _channelDescription;

    void onSubmit() {
      if (_fromkey.currentState!.validate()) {
        _fromkey.currentState!.save();
        final channel = Channel(
            channelName: _channelName!, description: _channelDescription!);

        Navigator.of(context).pop(
          channel,
        );
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Channel Details",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _fromkey,
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLength: 60,
                      decoration: const InputDecoration(
                        hintText: "Enter channel name",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(110, 255, 255, 255),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return "Channel cant be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) => _channelName = newValue!,
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: "Enter channel description",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(110, 255, 255, 255),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value == "") {
                          return "Channel cant be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) => _channelDescription = newValue!,
                    ),
                  ],
                ),
              ),
            ),
            OutlinedButton(
              onPressed: onSubmit,
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
