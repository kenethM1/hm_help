import 'dart:convert';

import 'package:intl/intl.dart';

class Propuestas {
  List<Propuesta> items = [];

  Propuestas();

  Propuestas.fromJsonList(List<dynamic> jsonlist) {
    for (var item in jsonlist) {
      final propuesta = new Propuesta.fromJsonMap(item);
      items.add(propuesta);
    }
  }
}

class Propuesta {
  String? rubro;
  String? rubroID;
  String? nombreUsuario;
  String? usuarioID;
  String? nombreContratista;
  String? contratistaID;
  String? nombre;
  String? descripcion;
  double? monto;
  String? id;
  DateTime? created;
  DateTime? updated;
  String? status;
  List<Imagen>? imagenes;

  Propuesta(
      {this.rubro,
      this.rubroID,
      this.contratistaID,
      this.usuarioID,
      this.nombreUsuario,
      this.nombreContratista,
      this.nombre,
      this.descripcion,
      this.monto,
      this.id,
      this.created,
      this.updated,
      this.status,
      this.imagenes});

  Propuesta.fromJsonMap(Map<String, dynamic> json) {
    rubro = json['rubro'];
    rubroID = json['rubroId'];
    nombreUsuario = json['nombreUsuario'];
    usuarioID = json['usuarioId'];
    nombreContratista = json['nombreContratista'];
    contratistaID = json['contratistaId'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    monto = json['monto'];
    id = json['id'];
    created = castStringtoDate(json['created']);
    updated = castStringtoDate(json['updated']);
    status = json['status'];
    imagenes =
        List<Imagen>.from(json["imagenes"].map((x) => Imagen.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "rubro": rubro,
        "nombreUsuario": nombreUsuario,
        "nombreContratista": nombreContratista,
        "nombre": nombre,
        "descripcion": descripcion,
        "monto": monto,
        "id": id,
        "status": status,
        "imagenes": List<dynamic>.from(imagenes!.map((x) => x.toJson())),
      };

  DateTime castStringtoDate(String fecha) {
    DateTime date = DateTime.parse(fecha.replaceAll('T', ' '));
    DateFormat("MMMM yyyy").format(date);
    return date;
  }
}

class Imagen {
  Imagen({
    this.url,
  });

  final String? url;

  factory Imagen.fromRawJson(String str) => Imagen.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Imagen.fromJson(Map<String, dynamic> json) => Imagen(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class MesAgrupado {
  String? mes;
  double? suma;

  MesAgrupado(
    this.mes,
    this.suma,
  );
}
