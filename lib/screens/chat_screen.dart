import 'package:flutter/material.dart';
import '../widgets/app_nav.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavShell(
      child: Center(
        child: Text('Chat', style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
