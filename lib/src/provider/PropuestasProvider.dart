import 'dart:async';
import 'dart:convert';
import 'package:hm_help/src/models/Propuesta.dart';
import 'package:hm_help/src/models/Rubro.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import "package:collection/collection.dart";
import 'package:json_annotation/json_annotation.dart';

class PropuestasProvider {
  final token = PreferenciasUsuario().token;
  final _propuestasStreamController =
      StreamController<List<Propuesta>>.broadcast();

  final _propuestasTotalStreamController = StreamController<String>.broadcast();

  Function(List<Propuesta>) get propuestasSink =>
      _propuestasStreamController.sink.add;

  Function(String) get propuestasTotalSink =>
      _propuestasTotalStreamController.sink.add;

  Stream<List<Propuesta>> get propuestasStream =>
      _propuestasStreamController.stream;

  Stream<String> get propuestasTotalStream =>
      _propuestasTotalStreamController.stream;

  void dispose() {
    _propuestasStreamController.close();
    _propuestasTotalStreamController.close();
  }

  static String _url = 'mahamtr1-001-site1.ctempurl.com';
  static String _path = 'api/Propuesta/GetMyPropuestas';

  final url = Uri.http(_url, _path);

  Future<List<Propuesta>> getPropuestas() async {
    final propuestas = await _procesarRespuesta();

    final existing = Set<Propuesta>();
    final unique =
        propuestas.where((propuestas) => existing.add(propuestas)).toList();

    propuestasSink(unique);

    return propuestas;
  }

  Future<List<Propuesta>> recargar(String idPropuesta) async {
    final propuestas = await _procesarRespuesta();

    final existing = Set<Propuesta>();

    final propuestasNoRepetidas =
        propuestas.where((propuestas) => existing.add(propuestas)).toList();

    propuestasNoRepetidas.removeWhere((element) => element.id == idPropuesta);

    propuestasSink(propuestasNoRepetidas);
    propuestas.forEach((element) {
      print(element.id);
    });
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

  Future<String> montoTotal() async {
    List<Propuesta> propuestas = await getPropuestas();

    final propuestasLimpias = erasePropuestas(propuestas);

    double total = propuestasLimpias.fold(0, (sum, item) => sum + item.monto!);

    propuestasTotalSink(total.toString());

    print('monto total: $total');

    return total.toString();
  }

  Future<bool> acceptPropuesta(Propuesta propuesta) async {
    final url = Uri.http(_url, '/api/Propuesta/UpdatePropuestaById');

    final jsonbody = {
      'id': propuesta.id,
      'contratistaId': propuesta.contratistaID,
      'rubroId': propuesta.rubroID,
      'nombre': propuesta.nombre,
      'descripcion': propuesta.descripcion,
      'monto': propuesta.monto,
      'status': 2,
      'imagenes': propuesta.imagenes
    };

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
        body: json.encode(jsonbody));

    return (response.statusCode == 200) ? true : false;
  }

  Future uploadPropuesta(Propuesta propuesta, List<String> imagenes) async {
    final url = Uri.http(_url, '/api/Propuesta/AddPropuesta');

    Map<String, dynamic> imgtoJson(String url) => {
          "url": url,
        };

    Map<String, dynamic> toJson() => {
          'contratistaID': propuesta.contratistaID,
          'rubroID': propuesta.rubroID,
          'nombre': propuesta.nombre,
          'descripcion': propuesta.descripcion,
          'monto': propuesta.monto,
          "imagenes": List<dynamic>.from(imagenes.map((x) => imgtoJson(x))),
        };

    final response = await http.post(
      url,
      body: json.encode(toJson()),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print(response.statusCode);
  }

  void removePropuesta(String propuestaID) async {
    String _url = 'mahamtr1-001-site1.ctempurl.com';
    String _path = 'api/Propuesta/DeletePropuestaById';

    final url = Uri.http(_url, _path);
    final jsonbody = {'id': propuestaID};

    final peticion = await http.delete(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode(jsonbody));

    bool isOk = verifyConnection(peticion);
    print(peticion.body);
  }

  bool verifyConnection(http.Response peticion) {
    if (peticion.statusCode != 200) {
      return false;
    } else
      return true;
  }

  Future<List<MesAgrupado>> gananciasPorMes() async {
    final propuestas = await _procesarRespuesta();
    final prefs = PreferenciasUsuario();

    final propuestasLimpias = erasePropuestas(propuestas);

    final groupByDate = groupBy(propuestasLimpias, (Propuesta orderpropuestas) {
      return '${orderpropuestas.updated!.month}';
    });
    List<MesAgrupado> listaAgrupada = [];

    groupByDate.forEach((fecha, listaPropuestas) {
      double suma = listaPropuestas
          .map((propuesta) => propuesta.monto)
          .fold(0, (previousValue, monto) => previousValue + monto!);

      MesAgrupado mes = MesAgrupado(fecha, suma);

      prefs.gananciaMaxima = suma.toInt();
      listaAgrupada.add(mes);
    });

    return listaAgrupada;
  }

  Future<List<Rubro>> getRubros() async {
    String _url = 'mahamtr1-001-site1.ctempurl.com';
    String path = 'api/Rubro/GetAllRubros';
    final token = PreferenciasUsuario().token;

    final url = Uri.http(
      _url,
      path,
    );

    final request = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    print(request.statusCode);
    final isOkay = verifyConnection(request);

    if (isOkay) {
      final decoded = json.decode(request.body);

      final rubros = Rubros.fromJsonList(decoded);

      return rubros.items;
    } else {
      return [];
    }
  }

  List<Propuesta> erasePropuestas(List<Propuesta> propuestas) {
    propuestas.removeWhere((element) =>
        element.status == 'En revisión' ||
        element.status == 'En proceso' ||
        element.status == 'Rechazado');
    return propuestas;
  }
}
