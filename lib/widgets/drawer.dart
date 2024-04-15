import 'package:ciscord/provider/channel_provider.dart';
import 'package:ciscord/widgets/channel_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String? _userImage;
  String? _userName;

  void loadUserCard() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        _userName = user.displayName;

        final storageRef = FirebaseStorage.instance.ref();

        storageRef
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
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
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

  @override
  void initState() {
    super.initState();
    loadUserCard();
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
