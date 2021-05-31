import 'package:flutter/material.dart';

class tipoCategoria extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, bottom: 20.0, top: 20.0),
      child: Container(decoration: _boxDecoration(context),
      child: Column(
      children: <Widget>[Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[_imagen(),],
    ),
       _textoCate(context),],
    ),
    ),
    );
  }

  BoxDecoration _boxDecoration(context){
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(25.0),
      boxShadow: <BoxShadow>[BoxShadow(
        color: Colors.black45,
        offset: Offset(4.0, 4.0),
    ),
    ],
    );
  }

  Widget _imagen(){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Image(image: AssetImage('assets/pintura.png'),
    ),
    );
  }

  Widget _textoCate(context){
    return Column(
      children: <Widget>[
        Text('Pintura',
        style: TextStyle(
        fontSize: 22.0,
        color: Colors.white,
    ),
    )
    ],
    );
  }
}

class tipoCategoria2 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, bottom: 20.0, top: 20.0),
      child: Container(
      decoration: _boxDecoration(context),
      child: Column(
      children: <Widget>[Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[_imagen(),],
    ),
       _textoCate(context),
    ],
    ),
    ),
    );
  }

  BoxDecoration _boxDecoration(context){
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(25.0),
      boxShadow: <BoxShadow>[BoxShadow(
        color: Colors.black45,
        offset: Offset(4.0, 4.0),
    ),
    ],
    );
  }

  Widget _imagen(){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Image(image: AssetImage('assets/plomeria.png'),
    ),
    );
  }

  Widget _textoCate(context){
    return Column(
      children: <Widget>[
        Text('Fontaneria',
          style: TextStyle(
          fontSize: 22.0,
          color: Colors.white,
    ),
    ),
    ],
    );
  }
}

class tipoCategoria3 extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, bottom: 20.0, top: 20.0),
      child: Container(
      decoration: _boxDecoration(context),
      child: Column(children: <Widget>[Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_imagen(),],
    ),
        _textoCate(context),
    ],
    ),
    ),
    );
  }

  BoxDecoration _boxDecoration(context){
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(25.0),
      boxShadow: <BoxShadow>[BoxShadow(
        color: Colors.black45,
        offset: Offset(4.0, 4.0),
    ),
    ],
    );
  }

  Widget _imagen(){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Image(image: AssetImage('assets/construir.png'),
    ),
    );
  }

  Widget _textoCate(context){
    return Column(
      children: <Widget>[
        Text('Construcción',
          style: TextStyle(
          fontSize: 22.0,
          color: Colors.white,
    ),
    )
    ],
    );
  }
}
