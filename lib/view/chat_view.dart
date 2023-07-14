import 'package:chat_ipssi/controller/chat_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _messageController = TextEditingController();
  final ChatController _chatController = ChatController();
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatController.sendMessage(widget.receiverUserID, _messageController.text);

      _messageController.clear();
    }
  }

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
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatController.getMessages(
        widget.receiverUserID,
        _fireBaseAuth.currentUser!.uid
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Chargement ...');
        }

        return ListView(
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _fireBaseAuth.currentUser!.uid)
      ? Alignment.centerRight
      : Alignment.centerLeft;

    var color = (data['senderId'] == _fireBaseAuth.currentUser!.uid)
      ? Colors.blue
      : Colors.red;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _fireBaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == _fireBaseAuth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color
              ),
              child: Text(
                data['message'],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10),
              fillColor: Colors.white,
              filled: true,
              hintText: 'Message',
            ),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
            size: 30
          )
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}