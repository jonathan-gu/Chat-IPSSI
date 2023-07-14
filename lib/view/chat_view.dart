import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String receiverUserPseudo;
  const ChatView({super.key, required this.receiverUserEmail, required this.receiverUserID, required this.receiverUserPseudo});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 14, 210, 100),
        centerTitle: true,
        title: Text(
          widget.receiverUserPseudo
        )
      ),
    );
  }
}