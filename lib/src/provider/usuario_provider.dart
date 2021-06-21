import 'dart:convert';
import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _url = 'mahamtr1-001-site1.ctempurl.com';
  Future<Map<String, dynamic>> login(String email, String password) async {
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
      guardarPreferencias(_prefs, respuestaJson, email);

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

  void guardarPreferencias(PreferenciasUsuario _prefs,
      Map<String, dynamic> respuestaJson, String email) {
    _prefs.token = respuestaJson['token'];
    _prefs.nombreUsuario = respuestaJson['nombre'];
    _prefs.imageUsuario = respuestaJson['image_URL'];
    _prefs.correoUsuario = email;
    _prefs.sexo = respuestaJson['sexo'];
    _prefs.apellidoUsuario = respuestaJson['apellido'];
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String nombre, String apellido, String email, String password) async {
    String _path = '/api/Usuario/SignUpUsuario';

    final url = Uri.http(_url, _path);
    final authData = {
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'password': password,
      'sexo': 'Masculino',
      'image_URL': 'https://www.creditosolidario.hn/csfrontend/images/user.png',
      'fecha': "2021-06-19T21:22:06.260Z"
    };

    final peticion = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(authData));

    Map<String, dynamic> respuestaJson = json.decode(peticion.body);

    print(peticion.statusCode);

    final isOk = new PropuestasProvider().verifyConnection(peticion);

    if (isOk) {
      return {'ok': true, 'rol': respuestaJson['rol']};
    } else {
      return {'ok': false, 'rol': respuestaJson['error']};
    }
  }

  Future updateUsuario(Usuario usuario) async {
    final preferencias = PreferenciasUsuario();

    final token = preferencias.token;
    final uri = Uri.http(_url, '/api/Usuario/UpdateMyProfile');
    final body = {
      "nombre": preferencias.nombreUsuario,
      "apellido": preferencias.apellidoUsuario,
      "imagenURL": usuario.image_URL,
      "sexo": preferencias.sexo
    };

    final response = await http.post(uri, body: json.encode(body), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });

    print(usuario.image_URL);

    print(response.statusCode);

    bool isOkay = new PropuestasProvider().verifyConnection(response);
  }
}
