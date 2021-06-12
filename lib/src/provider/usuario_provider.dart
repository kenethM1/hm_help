import 'dart:convert';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  get decodedResp => null;

  Future<Map<String, dynamic>> login(String email, String password) async {
    const String _url = 'mahamtr1-001-site1.ctempurl.com';
    const String _path = 'api/Usuario/Login';

    final _prefs = PreferenciasUsuario();

    final url = Uri.http(_url, _path);

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

    Map<String, dynamic> respuestaJson = json.decode(peticion.body);

    final isOk = new PropuestasProvider().verifyConnection(peticion);

    if (isOk) {
      _prefs.token = respuestaJson['token'];
      _prefs.nombreUsuario = respuestaJson['nombre'];
      _prefs.imageUsuario = respuestaJson['image_URL'];
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
    String _path = '/api/Usuario/SignUpUsuario';

    final url = Uri.http(_url, _path);
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

    final isOk = new PropuestasProvider().verifyConnection(peticion);

    if (isOk) {
      return {'ok': true, 'rol': respuestaJson['rol']};
    } else {
      return {'ok': false, 'rol': respuestaJson['error']};
    }
  }
}
