import 'package:flutter/material.dart';
import 'package:hm_help/src/styles/Styles.dart';

class tipoCategoria extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 100,
        child: Stack(children: <Widget>[
          Container(
            height: 200,
            width: 400,
            child: Opacity(
              opacity: 0.6,
              child: Image(
                image: AssetImage('assets/pintura.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: 200,
            alignment: Alignment.bottomLeft,
            child: Text("PINTURA", style: new Styles().estilo),
          ),
        ]),
      ),
    );

  }
}

class tipoCategoria2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      child: Stack(children: <Widget>[
        Container(
          height: 200,
          width: 400,
          child: Opacity(
            opacity: 0.6,
            child: Image(
              image: AssetImage('assets/fontaneria2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 200,
          alignment: Alignment.bottomLeft,
          child: Text(
            "FONTANERIA",
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]),
    );

  }
}

class tipoCategoria3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Stack(children: <Widget>[
        Container(
          height: 200,
          width: 400,
          child: Opacity(
            opacity: 0.6,
            child: Image(
              image: AssetImage('assets/construccion.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 200,
          alignment: Alignment.bottomLeft,
          child: Text(
            "CONSTRUCCION",
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]),
    );
  }
}
