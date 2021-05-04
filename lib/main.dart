import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/provider.dart';
import 'package:hm_help/src/pages/login_screen.dart';
import 'package:hm_help/src/pages/main_user_screen.dart';
import 'package:hm_help/src/pages/registro_contratista.dart';

void main() => runApp(MyApp());

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
          'principal': (_) => MainUserScreen()
        }));
  }
}
