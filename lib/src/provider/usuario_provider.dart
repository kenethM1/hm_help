import 'dart:convert';
import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioProvider {
  final String _url = 'mahamtr1-001-site1.ctempurl.com';
  Future<Map<String, dynamic>> login(String email, String password) async {
    const String _path = 'api/Usuario/Login';

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
      guardarPreferencias(respuestaJson, email);

      return {
        'ok': true,
        'token': respuestaJson['token'],
        'rol': respuestaJson['rol'],
        'imageURL': respuestaJson['image_URL']
      };
    } else {
      return {'ok': false, 'token': 'Correo o usuario incorrecto'};
    }
  }

  Future<void> guardarPreferencias(
      Map<String, dynamic> respuestaJson, String email) async {
    final _prefs = PreferenciasUsuario();

    String json = jsonEncode(respuestaJson);

    _prefs.usuario = json;

    _prefs.correoUsuario = email;
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email,
      String nombre,
      String apellido,
      String password,
      String sexo,
      String imagen_URL,
      String fecha) async {
    String _path = '/api/Usuario/SignUpUsuario';

    final url = Uri.http(_url, _path);
    final authData = {
      'email': email,
      'nombre': nombre,
      'apellido': apellido,
      'password': password,
      'sexo': sexo,
      'image_URL': imagen_URL,
      'fecha': fecha,
    };

    final peticion = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(authData));

    print(authData);

    Map<String, dynamic> respuestaJson = json.decode(peticion.body);

    final isConnectionOk = new PropuestasProvider().verifyConnection(peticion);

    return (isConnectionOk)
        ? {'ok': true, 'rol': respuestaJson['rol']}
        : {'ok': false, 'rol': respuestaJson['error']};
  }

  Future updateUsuario(Usuario usuario) async {
    final preferencias = PreferenciasUsuario();

    final token = preferencias.token;
    final uri = Uri.http(_url, '/api/Usuario/UpdateMyProfile');
    final body = {
      "nombre": preferencias.nombre,
      "apellido": preferencias.apellido,
      "imagenURL": usuario.imageURL,
      "sexo": preferencias.sexo
    };

    final response = await http.post(uri, body: json.encode(body), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });

    bool isOkay = new PropuestasProvider().verifyConnection(response);
  }
}
