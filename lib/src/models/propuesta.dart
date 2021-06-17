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
  List<String>? imagenes;

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
    rubroID = json['rubroID'];
    nombreUsuario = json['nombreUsuario'];
    usuarioID = json['usuarioID'];
    nombreContratista = json['nombreContratista'];
    contratistaID = json['contratistaID'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    monto = json['monto'];
    id = json['id'];
    created = castStringtoDate(json['created']);
    updated = castStringtoDate(json['updated']);
    status = json['status'];
    imagenes = getListImagenes(json['imagenes'] ?? []);
  }

  List<String> getListImagenes(List<dynamic> json) {
    List<String> imagenes = [];

    print(json.length);

    json.forEach((imagen) => imagenes.add(imagen['url']));

    return imagenes;
  }

  DateTime castStringtoDate(String fecha) {
    DateTime date = DateTime.parse(fecha.replaceAll('T', ' '));
    DateFormat("MMMM yyyy").format(date);
    return date;
  }
}

class MesAgrupado {
  String? mes;
  double? suma;

  MesAgrupado(
    this.mes,
    this.suma,
  );
}
