import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/pages/upload_propuesta.dart';

class ListaContratista extends StatelessWidget {
  showSimpleDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Informacion del contratista",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                          radius: 40,
                          child: FadeInImage(
                            placeholder: AssetImage('./assets/jar-loading.gif'),
                            image: NetworkImage(contratista.image_URL!),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    elevation: 5.0,
                    child: Text(
                      "Agregar Propuesta",
                    ),
                    onPressed: () {
                      showDialog(
                          context: context, builder: (_) => UploadPropuesta());
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  final Contratista contratista;

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
          leading: Icon(
            Icons.person,
            size: 50,
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
