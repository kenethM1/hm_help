import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  Future<Map<String, dynamic>> login(String email, String password) async {
    String _url = 'is2-grupo-2-be.herokuapp.com';
    final url = Uri.https(_url, '/users/login');
    print(url.path);
    final authData = {
      'email': email,
      'password': password,
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

    if (decodedResp.containsKey('token')) {
      return {'ok': true, 'token': decodedResp['token']};
    } else {
      return {'ok': false, 'token': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    String _url = 'is2-grupo-2-be.herokuapp.com';
    final url = Uri.https(_url, '/users/sign-up');
    final authData = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('role')) {
      return {'ok': true, 'role': decodedResp['role']};
    } else {
      return {'ok': false, 'role': decodedResp['error']['message']};
    }
  }
}
