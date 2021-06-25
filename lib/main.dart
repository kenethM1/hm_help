import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/bloc_provider/contratistaProvider.dart';
import 'package:hm_help/src/bloc/bloc_provider/provider.dart';
import 'package:hm_help/src/bloc/bloc_provider/proveedor.dart';
import 'package:hm_help/src/pages/PerfilUsuario.dart';
import 'package:hm_help/src/pages/UserProfile.dart';
import 'package:hm_help/src/pages/homePageUser.dart';
import 'package:hm_help/src/pages/login_screen.dart';
import 'package:hm_help/src/pages/logup_screen.dart';
import 'package:hm_help/src/pages/main_contratista_screen.dart';
import 'package:hm_help/src/pages/main_userScreen.dart';
import 'package:hm_help/src/pages/pdf_Contratista.dart';
import 'package:hm_help/src/pages/registro_contratista.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hm_help/src/provider/images_provider.dart';
import 'package:hm_help/src/provider/ui_provider.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider<ImagesProvider>(
            create: (_) => new ImagesProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'login',
          routes: {
            'login': (_) => ProviderBloc(child: LoginScreen()),
            'nuevoUser': (_) => Proveedor(child: LogupUsuario()),
            'mainUser': (_) => MainUsuarioScreen(),
            'registro': (_) => ProviderContratista(child: RegistroPage()),
            'homeUser': (_) => HomePageUser(),
            'principal': (_) => MainContratistaScreen(),
            'userProfile': (_) => UserProfile(),
            'perfilUsuario': (_) => PerfilUsuario(),
            'hojaVida': (_) => PdfContratistaPage(),
          }),
    );
  }
}
