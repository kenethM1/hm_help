import 'dart:async';
import 'dart:convert';

import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class ContratistasProvider {
  final token = PreferenciasUsuario().token;
  final _contratistasStreamController =
      StreamController<List<Usuario>>.broadcast();

  Function(List<Usuario>) get contratistaSink =>
      _contratistasStreamController.sink.add;

  Stream<List<Usuario>> get contratistaStream =>
      _contratistasStreamController.stream;

  void dispose() {
    _contratistasStreamController.close();
  }

  static String _url = 'mahamtr1-001-site1.ctempurl.com';
  static String _path = "api/Usuario/GetAllContratistas";

  final url = Uri.http(_url, _path);

  Future<List<Usuario>> getContratista() async {
    List<Usuario> contratista =
        await _procesarRespuesta('api/Usuario/GetAllContratistas');

    contratistaSink(contratista);

    return contratista;
  }

  Future<List<Usuario>> recargar(String idPropuesta) async {
    final contratistas =
        await _procesarRespuesta('api/Usuario/GetAllContratistas');
    final existing = Set<Usuario>();
    final unique = contratistas
        .where((constratistas) => existing.add(constratistas))
        .toList();

    unique.removeWhere((element) => element.id == idPropuesta);
    contratistaSink(unique);

    return contratistas;
  }

  Future<List<Usuario>> _procesarRespuesta(String path) async {
    final url = Uri.http(_url, path);
    final peticion = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    bool isOk = verifyConnection(peticion);

    if (isOk) {
      final decodedData = json.decode(peticion.body);

      final usuarios = new Usuarios.fromJsonList(decodedData);

      return usuarios.items;
    } else {
      return [];
    }
  }

  Future<String?> userImageURL(String? idUsuario) async {
    final usuarios = await _procesarRespuesta('/api/Usuario/GetAllUsers');

    for (var usuario in usuarios) {
      if (usuario.id == idUsuario!) {
        return usuario.image_URL!;
      }
    }

    return 'https://pics.freeicons.io/uploads/icons/png/6822363841598811069-512.png';
  }

  bool verifyConnection(http.Response peticion) {
    if (peticion.statusCode != 200) {
      return false;
    } else
      return true;
  }
}
