import 'package:chat_ipssi/controller/auth_service_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signOut() {
    final authService = Provider.of<AuthServiceController>(context, listen: false);
  
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(21, 14, 210, 100),
        title: const Text("Page d'accueil"),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _builderUserList(),
    );
  }

  Widget _builderUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Chargement ...');
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _builderUserListItem(doc)).toList(),
        );
      },
    );
  }

    Widget _builderUserListItem(DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      if(_auth.currentUser!.email != data['email']) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.blue
          ),
          title: Text(data['pseudo']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatView(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['uid'],
                  receiverUserPseudo: data['pseudo'],
                ),
              ),
            );
          },
        );
      } else {
        return Container();
      }
    }
}