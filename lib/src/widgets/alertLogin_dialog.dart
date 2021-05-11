import 'package:flutter/material.dart';

class AlertLogin extends StatelessWidget {
  final String? titulo = '';
  final String? mensaje = '';

  const AlertLogin(
      {Key? key, required String? titulo, required String? mensaje})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text(this.titulo.toString()),
        elevation: 3,
        content: Text('Regresa y revisa bien tus datos'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('Okay'))
        ],
      ),
    );
  }
}
