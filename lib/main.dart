import 'package:chat_ipssi/controller/auth_controller.dart';
import 'package:chat_ipssi/view/login_view.dart';
import 'package:chat_ipssi/view/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthController(),
    );
  }
}