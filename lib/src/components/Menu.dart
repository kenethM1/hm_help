import 'package:flutter/material.dart';

class Menu extends StatefulWidget{
  @override
  _EstadoMenu createState() => _EstadoMenu();
}

class _EstadoMenu extends State<Menu>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text("Inicio"), 
    ),
          BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text("Ajustes"), 
    ),
    ],
    ),
    );
  }
}