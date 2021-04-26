import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/provider.dart';
import 'package:hm_help/src/pages/login_screen.dart';
import 'package:hm_help/src/pages/registro_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {'login':  (_) => LoginScreen(),
                'registro': (_) => registro_Page()
      }
    )
    );
  }
}
