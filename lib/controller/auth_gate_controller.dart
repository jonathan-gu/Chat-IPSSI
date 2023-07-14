import 'package:chat_ipssi/controller/auth_controller.dart';
import 'package:chat_ipssi/main.dart';
import 'package:chat_ipssi/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthGateController extends StatelessWidget {
  const AuthGateController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeView();
          }
          else {
            return const AuthController();
          }
        },
      ),
    );
  }
}