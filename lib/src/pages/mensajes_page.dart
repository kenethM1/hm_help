import 'package:flutter/material.dart';

class MensajePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogoTemporal(),
              MensajeTemporal(),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoTemporal extends StatelessWidget {
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
      ),
    );
  }
}

class MensajeTemporal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 100.0, right: 15.0, left: 15.0),
      child: Text(
        "Muy pronto disfrutaras de este servicio...", 
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white
          ),
      ),
    );
  }
}

