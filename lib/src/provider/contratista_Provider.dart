import 'dart:convert';

import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {


  Future<Map<String, dynamic>> registro(String nombre, String correo,
      String contra, String fecha, String genero, String apellido) async {
    String _url = 'mahamtr1-001-site1.ctempurl.com';

    final _prefs = PreferenciasUsuario();

    final url = Uri.http(_url, '/api/Usuario/SignUpContratista');
    print(url.path);
    final authData = {
      'email': correo,
      'nombre': nombre,
      'apellido': apellido,
      'password': contra,
      'fecha': fecha,
    };

    final resp = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(authData));

    print(authData);

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (resp.statusCode == 200) {
      _prefs.token = decodedResp['token'];
      return {
        'ok': true,
        'token': decodedResp['token'],
        'nombre': decodedResp['nombre']
      };
    } else {
      return {'ok': false, 'token': 'Error en algún dato.'};
    }
  }
}
