import 'package:flutter/material.dart';
import 'package:hm_help/src/pages/login_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {'login':  (_) => LoginScreen()
      }
    );
  }
}
