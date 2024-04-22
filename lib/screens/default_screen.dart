import 'package:ciscord/provider/channel_provider.dart';
import 'package:ciscord/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class DefaultScreen extends ConsumerStatefulWidget {
  const DefaultScreen({super.key});

  @override
  ConsumerState<DefaultScreen> createState() {
    return _DefaultScreenState();
  }
}

class _DefaultScreenState extends ConsumerState<DefaultScreen> {
  Widget userCard = const Card(
    child: Column(
      children: [
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Image(
            image: AssetImage("lib/assets/avatar.png"),
          ),
        ),
        Text("user",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ],
    ),
  );

  String? _userId;

  void loadUserDetails() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _userId = user.uid;
        FirebaseStorage.instance
            .ref()
            .child("images/${user.uid}/userImage")
            .getDownloadURL()
            .then((imageUrl) {
          setState(() {
            userCard = Card(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    user.displayName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          });
        });
      }
    });
  }

  bool _forSearch = false;
  final channelid = TextEditingController();

  void searchChannel() async {
    if (channelid.text.isNotEmpty) {
      final channelName =
          await ref.watch(channelData.notifier).getchannel(channelid.text);
      print(channelName);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(channelName),
            content: const Text("do you want to add this channel?"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    if (_userId != null) {
                      ref
                          .watch(channelData.notifier)
                          .addExcistingChannelToUser(channelid.text, _userId!);
                      setState(() {
                        _forSearch = false;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("yes")),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("no"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        toolbarHeight: 175,
        flexibleSpace: HeroMode(
          child: userCard,
        ),
      ),
      drawer: const ChannelDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "lib/assets/sleep.json",
              height: 200,
              width: 200,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  _forSearch = true;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 55,
                width: _forSearch == false ? 150 : 400,
                child: _forSearch == false
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          Text("Channel Id"),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: channelid,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Channel id",
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: searchChannel,
                            icon: const Icon(Icons.search),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
