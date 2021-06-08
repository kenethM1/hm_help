import 'dart:async';
import 'dart:convert';

import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class ContratistasProvider {
  final token = PreferenciasUsuario().token;
  final _contratistasStreamController =
      StreamController<List<Contratista>>.broadcast();

  Function(List<Contratista>) get contratistaSink =>
      _contratistasStreamController.sink.add;

  Stream<List<Contratista>> get contratistaStream =>
      _contratistasStreamController.stream;

  void dispose() {
    _contratistasStreamController.close();
  }

  static String _url = 'mahamtr1-001-site1.ctempurl.com';
  static String _path = 'api/Usuario/GetAllContratistas';

  final url = Uri.http(_url, _path);

  Future<List<Contratista>> getContratista() async {
    final contratista = await _procesarRespuesta();

    contratistaSink(contratista);

    return contratista;
  }

  Future<List<Contratista>> recargar(String idPropuesta) async {
    final contratistas = await _procesarRespuesta();
    final existing = Set<Contratista>();
    final unique = contratistas
        .where((constratistas) => existing.add(constratistas))
        .toList();

    unique.removeWhere((element) => element.id == idPropuesta);
    contratistaSink(unique);

    return contratistas;
  }

  Future<List<Contratista>> _procesarRespuesta() async {
    final peticion = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    bool isOk = verifyConnection(peticion);

    if (isOk) {
      final decodedData = json.decode(peticion.body);

      final contratistas = new Contratistas.fromJsonList(decodedData);

      return contratistas.items;
    } else {
      return [];
    }
  }

  bool verifyConnection(http.Response peticion) {
    if (peticion.statusCode != 200) {
      return false;
    } else
      return true;
  }
}
