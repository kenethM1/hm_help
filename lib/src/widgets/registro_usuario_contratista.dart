import 'package:flutter/material.dart';
import 'package:hm_help/src/styles/Styles.dart';

class SignUpDecide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = Styles();
    return Container(
      child: AlertDialog(
          elevation: 10,
          contentPadding: EdgeInsets.all(5),
          insetPadding: EdgeInsets.only(bottom: 250, top: 250),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Deseas registrarte como:',
                style: TextStyle(fontSize: 18),
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 200, height: 50),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        animationDuration: Duration(seconds: 1)),
                    onPressed: () => Navigator.pushNamed(context, 'nuevoUser'),
                    child: Text(
                      'Usuario',
                      style: style.estiloWhite,
                    )),
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 200, height: 50),
                child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, 'registro'),
                    child: Text(
                      'Contratista',
                      style: style.estiloWhite,
                    )),
              )
            ],
          )),
    );
  }
}
