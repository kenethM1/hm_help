import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/provider.dart';
import 'package:hm_help/src/pages/login_screen.dart';
import 'package:hm_help/src/pages/main_contratista_screen.dart';
import 'package:hm_help/src/pages/registro_contratista.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            initialRoute: 'principal',
            routes: {
          'login': (_) => LoginScreen(),
          'registro': (_) => RegistroPage(),
          'principal': (_) => MainContratistaScreen()
        }));
  }
}
