import 'package:chat_ipssi/view/login_view.dart';
import 'package:chat_ipssi/view/register_view.dart';
import 'package:flutter/material.dart';

class AuthController extends StatefulWidget {
  const AuthController({super.key});

  @override
  State<AuthController> createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController> {
  bool showLoginView = true;

  void toggleViews() {
    setState(() {
      showLoginView = !showLoginView;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginView) {
      return LoginView(onTap: toggleViews);
    }
    else {
      return RegisterView(onTap: toggleViews);
    }
  }
}