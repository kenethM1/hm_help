import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Logo(),
              _form(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form() {
    return Container(
        height: 400,
        color: Colors.white,
        child: Column(children: [
          Input_usuario(),
          Input_Pass(),
          PasswordRecovery_button(),
          SizedBox(
            height: 30,
          ),
          Login_button(),
          Social_signIn_button(),
          TextButton(
              onPressed: () {},
              child: Text(
                '¿No tienes cuenta? Registrate!',
                style: TextStyle(
                    color: Colors.black, 
                    fontWeight: FontWeight.bold),
              ))
        ]));
  }
}

class Social_signIn_button extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25),
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SignInButton(Buttons.Google, elevation: 0, onPressed: () {})],
      ),
    );
  }
}

class PasswordRecovery_button extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(primary: Colors.grey.shade500),
        child: Text('Olvidaste tu contraseña?'));
  }
}

class Login_button extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 50,
      child: ElevatedButton(
          child: Text('Iniciar Sesion'),
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          onPressed: () {}),
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
