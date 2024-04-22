import 'package:ciscord/models/channel_model.dart';
import 'package:ciscord/provider/channel_provider.dart';
import 'package:ciscord/screens/default_screen.dart';
import 'package:ciscord/screens/login_screen.dart';
import 'package:ciscord/widgets/add_channel.dart';
import 'package:ciscord/widgets/channel_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChannelDrawer extends ConsumerStatefulWidget {
  const ChannelDrawer({super.key});

  @override
  ConsumerState<ChannelDrawer> createState() {
    return _ChannelDrawerState();
  }
}

class _ChannelDrawerState extends ConsumerState<ChannelDrawer> {
  Widget userCard = const Card(
    child: SizedBox(
      height: 150,
      width: double.infinity,
      child: Text(
        "User Card",
        textAlign: TextAlign.center,
      ),
    ),
  );
  String? _userId;
  String? _userName;
  String? _userImage;

  void loadUserCard() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        _userId = user.uid;
        _userName = user.displayName;
        ref.watch(channelData.notifier).loadChannels(_userId!);
        final storageRef = FirebaseStorage.instance.ref();

        storageRef
            .child("images/${user.uid}/userImage")
            .getDownloadURL()
            .then((imageUrl) {
          _userImage = imageUrl;
          setState(() {
            userCard = InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const DefaultScreen(),
                  ),
                );
              },
              child: Card(
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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserCard();
  }

  void createChannel() async {
    Channel channelDetails = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddChannel(),
      ),
    );

    final added = await ref.watch(channelData.notifier).addChannelDirect(
          channelDetails,
          _userId!,
        );
    Navigator.of(context).pop();

    if (added == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Channel added")));
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  void logOutUser() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            "Are you sure?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                });
              },
              child: const Text("yes"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("no"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final channelSet = ref.watch(channelData);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: userCard,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: channelSet.length,
              itemBuilder: (context, index) {
                return ChannelTile(
                  channelName: channelSet[index].channelName,
                  ownId: channelSet[index].id,
                  userId: _userId ?? "userid",
                  userName: _userName ?? "user",
                  userImage: _userImage ?? "userImage",
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                OutlinedButton.icon(
                  onPressed: createChannel,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text(
                    "create channel",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: logOutUser,
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    "log out",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
