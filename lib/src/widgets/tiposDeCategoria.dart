import 'package:flutter/material.dart';
import 'package:hm_help/src/styles/Styles.dart';

class tipoCategoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 700,
      child: Stack(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 200,
            width: 400,
            child: Image(
              image: AssetImage('assets/pintura.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              width: 400,
              height: 200,
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey.withOpacity(0.0), Colors.black],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter))),
        ),
        Container(
          height: 200,
          alignment: Alignment.bottomCenter,
          child: Text("PINTURA",
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              )),
        ),
      ]),
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
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 200,
            width: 400,
            child: Image(
              image: AssetImage('assets/fontaneria2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              width: 400,
              height: 200,
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey.withOpacity(0.0), Colors.black],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter))),
        ),
        Container(
          height: 200,
          alignment: Alignment.bottomCenter,
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
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 200,
            width: 400,
            child: Image(
              image: AssetImage('assets/construccion.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              width: 400,
              height: 200,
              decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey.withOpacity(0.0), Colors.black],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter))),
        ),
        Container(
          height: 200,
          alignment: Alignment.bottomCenter,
          child: Text(
            "CONSTRUCCIÓN",
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
