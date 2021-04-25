import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [Logo(), Input_usuario(), Input_Pass()],
          ),
        ),
      ),
    );
  }
}

class Input_Pass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: TextField(
        scrollPadding: EdgeInsets.only(bottom: 15),
        autocorrect: false,
        //maxLength: 25,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            focusColor: Colors.blue,
            fillColor: Colors.grey.shade300,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: 'Contraseña',
            hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 21,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class Input_usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: TextField(
        scrollPadding: EdgeInsets.only(bottom: 15),
        autocorrect: false,
        //maxLength: 25,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            focusColor: Colors.blue,
            fillColor: Colors.grey.shade300,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: 'Usuario',
            hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 21,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      color: Colors.blue.shade300,
      child: Image(
        height: 250,
        width: 250,
        image: AssetImage('assets/logo.png'),
        //fit: BoxFit.contain,
      ),
    );
  }
}
