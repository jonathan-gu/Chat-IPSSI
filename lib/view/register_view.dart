import 'package:chat_ipssi/controller/auth_service_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  final void Function()? onTap;
  const RegisterView({super.key, required this.onTap});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pseudoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signUp() async {
    final authService = Provider.of<AuthServiceController>(context, listen:false);

    try {
      await authService.signUpWithEmailAndPasswordAndPseudo(
        emailController.text,
        passwordController.text,
        pseudoController.text
      );
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            exception.toString()
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(21, 14, 210, 100),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text(
                'Chat IPSSI',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Adresse email',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: pseudoController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Pseudo',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Mot de passe',
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 200,
                child: GestureDetector(
                  onTap: signUp,
                  child: const ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    onPressed: null,
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    )
                  ),
                )
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  "Se connecter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}