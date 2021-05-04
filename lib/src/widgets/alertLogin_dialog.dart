import 'package:flutter/material.dart';

class AlertLogin extends StatelessWidget {
  const AlertLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text('Credenciales no validas'),
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
