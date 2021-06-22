import 'dart:convert';

import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class ContratistaProvider {
  String _url = 'mahamtr1-001-site1.ctempurl.com';
  final header = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  Future<Map<String, dynamic>> registro(String nombre, String correo,
      String contra, String fecha, String genero, String apellido) async {
    final _prefs = PreferenciasUsuario();

    final url = Uri.http(_url, '/api/Usuario/SignUpContratista');
    final authData = {
      'nombre': nombre,
      'email': correo,
      'password': contra,
      'fecha': fecha,
      'genero': genero,
      'apellido': apellido,
      'cvURL': _prefs.cvUsuario
    };

    final resp =
        await http.post(url, headers: header, body: json.encode(authData));

    final decodedResp = jsonDecode(resp.body);

    if (resp.statusCode == 200) {
      String json = jsonEncode(resp.body);
      _prefs.usuario = json;
      return {
        'ok': true,
        'token': decodedResp['token'],
        'nombre': decodedResp['nombre']
      };
    } else {
      return {'ok': false, 'token': 'Error en algún dato.'};
    }
  }

  Future<Map<String, dynamic>> nuevoContratista(
      Usuario user, String contrasena) async {
    String _url = 'mahamtr1-001-site1.ctempurl.com';

    final url = Uri.http(_url, '/api/Usuario/SignUpContratista');
    final authData = {
      'nombre': user.nombre,
      'email': user.correo,
      'password': contrasena,
      'fecha': DateTime.parse(user.fechaNacimiento!).toIso8601String(),
      'sexo': user.sexo,
      'apellido': user.apellido,
      'image_URL': 'https://electronicssoftware.net/wp-content/uploads/user.png'
    };

    final peticion =
        await http.post(url, headers: header, body: json.encode(authData));

    Map<String, dynamic> respuestaJson = json.decode(peticion.body);

    print(peticion.statusCode);

    if (respuestaJson.containsKey('rol')) {
      return {'ok': true, 'rol': respuestaJson['rol']};
    } else {
      return {'ok': false, 'rol': respuestaJson['error']};
    }
  }
}
