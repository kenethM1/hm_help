import 'package:flutter/material.dart';
import 'package:hm_help/src/models/contratistas.dart';

class ListaContratista extends StatelessWidget {
  final Contratista contratista;

  const ListaContratista({
    Key? key,
    required this.contratista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
      child: Container(
        decoration: _boxDecoration(),
        // height: 120,
        child: ListTile(
          subtitle: Text(
            contratista.correo.toString(),
            style: TextStyle(fontSize: 14),
          ),
          leading: Icon(
            Icons.person,
            size: 90,
          ),
          title: Text(
            contratista.nombre.toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

BoxDecoration _boxDecoration() {
  return BoxDecoration(
    color: Colors.blue.shade300,
    borderRadius: BorderRadius.circular(20),
  );
}
