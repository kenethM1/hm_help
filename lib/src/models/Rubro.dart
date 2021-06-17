import 'dart:convert';

Rubro rubroFromJson(String str) => Rubro.fromJson(json.decode(str));

String rubroToJson(Rubro data) => json.encode(data.toJson());

class Rubros {
  List<Rubro> items = [];

  Rubros();

  Rubros.fromJsonList(List<dynamic> jsonlist) {
    for (var item in jsonlist) {
      final rubro = new Rubro.fromJson(item);
      items.add(rubro);
    }
  }
}

class Rubro {
  String? nombre;
  String? id;

  Rubro({
    this.nombre,
    this.id,
  });

  factory Rubro.fromJson(Map<String, dynamic> json) => Rubro(
        nombre: json["nombre"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "id": id,
      };
}
