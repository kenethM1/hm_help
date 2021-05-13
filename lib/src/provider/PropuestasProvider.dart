import 'dart:async';
import 'dart:convert';

import 'package:hm_help/src/models/propuesta.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class PropuestasProvider {
  final token = PreferenciasUsuario().token;

  String _url = 'mahamtr1-001-site1.ctempurl.com';

  final url = Uri.http(
      'mahamtr1-001-site1.ctempurl.com', 'api/Propuesta/GetMyPropuestas');

  List<Propuesta> _propuestas = [];

  final _propuestasStreamController =
      StreamController<List<Propuesta>>.broadcast();

  Function(List<Propuesta>) get propuestasSink =>
      _propuestasStreamController.sink.add;

  Stream<List<Propuesta>> get propuestasStream =>
      _propuestasStreamController.stream;

  void dispose() {
    _propuestasStreamController.close();
  }

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
    print(peticion.statusCode);

    if (peticion.statusCode == 200) {
      final decodedData = json.decode(peticion.body);
      print(token);
      print(decodedData);

      final propuestas = new Propuestas.fromJsonList(decodedData);

      print(propuestas.items[0].nombreContratista);

      return propuestas.items;
    } else {
      print('No hay propuestas');
      return [];
    }
  }
}
