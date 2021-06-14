import 'package:flutter/material.dart';

class AlertLogin extends StatelessWidget {
  const AlertLogin({Key? key, required this.titulo, required this.mensaje})
      : super(key: key);

  final String? titulo;
  final String? mensaje;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text(this.titulo.toString()),
        elevation: 3,
        content: Text(mensaje.toString()),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('Okay'))
        ],
      ),
    );
  }
}
