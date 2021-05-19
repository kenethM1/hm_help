// Generated by https://quicktype.io
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
  String? nombreUsuario;
  String? nombreContratista;
  String? nombre;
  String? descripcion;
  double? monto;
  String? id;

  Propuesta(
      {this.rubro,
      this.nombreUsuario,
      this.nombreContratista,
      this.nombre,
      this.descripcion,
      this.monto,
      this.id});

  Propuesta.fromJsonMap(Map<String, dynamic> json) {
    rubro = json['rubro'];
    nombreUsuario = json['nombreUsuario'];
    nombreContratista = json['nombreContratista'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    monto = json['monto'];
    id = json['id'];
  }
}
