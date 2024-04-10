import 'package:ciscord/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});
  @override
  State<DefaultScreen> createState() {
    return _DefaultScreenState();
  }
}

class _DefaultScreenState extends State<DefaultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Example text",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Colors.white,
      ),
      drawer: const ChannelDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              "lib/assets/sleep.json",
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
