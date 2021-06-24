import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/pages/upload_propuesta.dart';

class ListaContratista extends StatelessWidget {
  showSimpleDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: AlertDialog(
                contentPadding: EdgeInsets.all(0),
                insetPadding: EdgeInsets.only(bottom: 150, top: 150),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                elevation: 10,
                content: Container(
                    height: 250,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Informacion del contratista",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                          radius: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              placeholder:
                                  AssetImage('./assets/jar-loading.gif'),
                              image: NetworkImage(contratista.imageURL!),
                            ),
                          ),
                        ),
                        Text(
                          contratista.nombre.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(contratista.correo.toString()),
                        Text(contratista.rol.toString())
                      ],
                    )),
                actions: [
                  MaterialButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    elevation: 5.0,
                    child: Text(
                      "Agregar Propuesta",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              UploadPropuesta(contratista: contratista));
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  final Usuario contratista;

  const ListaContratista({
    Key? key,
    required this.contratista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: Container(
        decoration: _boxDecoration(),
        height: 80,
        child: ListTile(
          subtitle: Text(
            contratista.correo.toString(),
            style: TextStyle(fontSize: 16),
          ),
          leading: Container(
            child: CircleAvatar(
              radius: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(contratista.imageURL!),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          title: Text(
            contratista.nombre.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            showSimpleDialog(context);
          },
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
