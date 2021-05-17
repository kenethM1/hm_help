import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/contratistaProvider.dart';
import 'package:hm_help/src/bloc/provider.dart';
import 'package:hm_help/src/bloc/provider2.dart';
import 'package:hm_help/src/pages/login_screen.dart';
import 'package:hm_help/src/pages/logup_screen.dart';
import 'package:hm_help/src/pages/main_contratista_screen.dart';
import 'package:hm_help/src/pages/pdf_Contratista.dart';
import 'package:hm_help/src/pages/registro_contratista.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final _prefs = new PreferenciasUsuario();

  await _prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'registro',
        routes: {
          'login': (_) => ProviderBloc(child: LoginScreen()),
          'nuevoUser': (_) => Provider2(child: LogupUsuario()),
          'registro': (_) => ProviderContratista(child: RegistroPage()),
          'principal': (_) => MainContratistaScreen(),
          'hojaVida': (_) => PdfContratistaPage(),
        });
  }
}
