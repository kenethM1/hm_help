import 'dart:convert';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  Future<Map<String, dynamic>> login(String email, String password) async {
    String _url = 'mahamtr1-001-site1.ctempurl.com';

    final _prefs = PreferenciasUsuario();

    final url = Uri.http(_url, 'api/Usuario/Login');

    print(url.path);
    final authData = {
      'email': email,
      'password': password,
    };

    final peticion = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(authData));

    print(authData);

    Map<String, dynamic> respuestaJson = json.decode(peticion.body);

    print(respuestaJson);

    if (peticion.statusCode == 200) {
      _prefs.token = respuestaJson['token'];
      _prefs.nombreUsuario = respuestaJson['nombre'];
      return {
        'ok': true,
        'token': respuestaJson['token'],
        'rol': respuestaJson['rol']
      };
    } else {
      return {'ok': false, 'token': 'Correo o usuario incorrecto'};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String nombre, String apellido, String email, String password) async {
    String _url = 'mahamtr1-001-site1.ctempurl.com';

    final url = Uri.http(_url, '/api/Usuario/SignUpUsuario');
    final authData = {
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'password': password,
    };

    final peticion = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(authData));

    Map<String, dynamic> respuestaJson = json.decode(peticion.body);

    if (respuestaJson.containsKey('rol')) {
      return {'ok': true, 'rol': respuestaJson['rol']};
    } else {
      return {'ok': false, 'rol': respuestaJson['error']};
    }
  }
}
