import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  Future nuevoUsuario(String email, String password) async {
    String _url = 'https://is2-grupo-2-be.herokuapp.com/';
    final url = Uri.https(_url,'/users/login');
    final authData = {
      'email': email,
      'paswword': password,
    };

    final resp =
        await http.post(url, body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);
  }
}
