import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: HomePage()),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Chat IPSSI'),
      //   backgroundColor: Color.fromRGBO(21, 14, 210, 100),
      // )
      body: Container(
        color: Color.fromRGBO(21, 14, 210, 100),
        height: double.infinity,
        width: double.infinity,
        child: const Center(
          child: Column(
            children: [
              SizedBox(height: 200),
              Text(
                'Chat IPSSI',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 350,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Adresse email',
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 350,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Mot de passe',
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: null,
                  child: Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  )
                )
              ),
              SizedBox(height: 20),
              Text(
                'Inscription',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
