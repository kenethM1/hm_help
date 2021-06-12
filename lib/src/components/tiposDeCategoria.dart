import 'package:flutter/material.dart';

class tipoCategoria extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      child: Stack(
        children: <Widget>[
          Container(
            height: 300,
            child: Opacity(
              opacity: 0.6,
             child: Image(
              image: AssetImage('assets/pintura.jpg'),
              fit: BoxFit.fill,
            ), 
            ),
            
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text("PINTURA",
            style: TextStyle(fontSize: 30,
            color: Colors.blue.shade400,
            fontWeight: FontWeight.bold,
            ),
            ),
          )
        ]
      ),
    );   
  }
}

class tipoCategoria2 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      child: Stack(
        children: <Widget>[
          Container(
            height: 300,
            child: Opacity(
              opacity: 0.6,
             child: Image(
              image: AssetImage('assets/fontaneria2.jpg'),
              fit: BoxFit.fill,
            ), 
            ),
            
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text("FONTANERIA",
            style: TextStyle(fontSize: 30, color: Colors.blue,
            fontWeight: FontWeight.bold,
            ),
            ),
          )
        ]
      ),
    );
  }

 
}

class tipoCategoria3 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(10),
      height: 100,
      child: Stack(
        children: <Widget>[
          Container(
            height: 300,
            child: Opacity(
              opacity: 0.6,
             child: Image(
              image: AssetImage('assets/construccion.jpg'),
              fit: BoxFit.fill,
            ), 
            ),
            
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text("CONSTRUCCION",
            style: TextStyle(fontSize: 30, color: Colors.blue,
            fontWeight: FontWeight.bold,
            ),
            ),
          )
        ]
      ),
    );
  }

}
