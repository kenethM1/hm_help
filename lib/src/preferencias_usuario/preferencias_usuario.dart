import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences? _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String get imgURL {
    Map user = decodeUserData();

    return user['image_URL'];
  }

  String get token {
    Map user = decodeUserData();

    return user['token'];
  }

  String get nombre {
    Map user = decodeUserData();

    return user['nombre'];
  }

  String get apellido {
    Map user = decodeUserData();

    return user['apellido'];
  }

  String get sexo {
    Map user = decodeUserData();

    return user['sexo'];
  }

  int? get gananciaMaxima {
    return _prefs!.getInt('gananciaMaxima');
  }

  set gananciaMaxima(int? value) {
    _prefs!.setInt('gananciaMaxima', value!);
  }

  set usuario(String json) {
    _prefs!.setString('userData', json);
  }

  String get cvUsuario {
    return _prefs!.getString('cvUsuario') ?? '';
  }

  set cvUsuario(String value) {
    _prefs!.setString('cvUsuario', value);
  }

  String get correoUsuario {
    return _prefs!.getString('correo') ?? '';
  }

  set correoUsuario(String correo) {
    _prefs!.setString('correo', correo);
  }

  Map decodeUserData() {
    String? data = _prefs!.getString('userData');

    Map user = jsonDecode(data!);

    return user;
  }
}
