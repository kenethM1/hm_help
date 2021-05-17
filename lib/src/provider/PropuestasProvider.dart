import 'dart:async';
import 'dart:convert';

import 'package:hm_help/src/models/propuesta.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class PropuestasProvider {
  final token = PreferenciasUsuario().token;
  final _propuestasStreamController =
      StreamController<List<Propuesta>>.broadcast();

  Function(List<Propuesta>) get propuestasSink =>
      _propuestasStreamController.sink.add;

  Stream<List<Propuesta>> get propuestasStream =>
      _propuestasStreamController.stream;

  void dispose() {
    _propuestasStreamController.close();
  }

  static String _url = 'mahamtr1-001-site1.ctempurl.com';
  static String _path = 'api/Propuesta/GetMyPropuestas';

  final url = Uri.http(_url, _path);

  List<Propuesta> _propuestas = [];

  Future<List<Propuesta>> getPropuestas() async {
    final propuestas = await _procesarRespuesta();

    _propuestas.addAll(propuestas);

    propuestasSink(_propuestas);

    return propuestas;
  }

  Future<List<Propuesta>> _procesarRespuesta() async {
    final peticion = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    bool isOk = verifyConnection(peticion);

    if (isOk) {
      final decodedData = json.decode(peticion.body);

      final propuestas = new Propuestas.fromJsonList(decodedData);

      return propuestas.items;
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
