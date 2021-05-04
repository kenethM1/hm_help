import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/widgets/line_chart.dart';

class MainContratistaScreen extends StatelessWidget {
  const MainContratistaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tamano = MediaQuery.of(context).size;
    TextStyle estilo = TextStyle(
        color: Colors.blue.shade200, fontSize: 24, fontWeight: FontWeight.bold);
    TextStyle estiloWhite = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ChartPage(estilo: estilo),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: ListView(
                children: [
                  Tile_Oferta(
                      rubro: 'Pintura',
                      nombre: "Keneth",
                      estiloWhite: estiloWhite),
                  Tile_Oferta(
                      rubro: 'Albanil',
                      nombre: "Fernando",
                      estiloWhite: estiloWhite),
                  Tile_Oferta(
                      rubro: 'Fontaneria',
                      nombre: "Hugo",
                      estiloWhite: estiloWhite),
                ],
              ),
              height: tamano.height * 0.4678,
              width: tamano.width,
              color: Colors.blue.shade200,
            )
          ],
        ),
      ),
    );
  }
}

class Tile_Oferta extends StatelessWidget {
  const Tile_Oferta({
    Key? key,
    required this.estiloWhite,
    required this.nombre,
    required this.rubro,
  }) : super(key: key);

  final TextStyle estiloWhite;
  final String? nombre;
  final String? rubro;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(
        rubro.toString(),
        style:
            estiloWhite.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
      ),
      leading: Icon(
        Icons.person,
        size: 50,
      ),
      title: Text(
        nombre.toString(),
        style: estiloWhite,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Trailing_button(
            color: Colors.blue,
            texto: "ACEPTAR",
          ),
          Trailing_button(color: Colors.red, texto: 'RECHAZAR')
        ],
      ),
    );
  }
}

class Trailing_button extends StatelessWidget {
  const Trailing_button({
    Key? key,
    required String? this.texto,
    required Color? this.color,
  }) : super(key: key);

  final String? texto;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(40, 40),
        shape: StadiumBorder(),
        elevation: 5,
        primary: color,
      ),
      child: Text('ACEPTAR'),
      onPressed: () {},
    );
  }
}

class ChartPage extends StatelessWidget {
  const ChartPage({
    Key? key,
    required this.estilo,
  }) : super(key: key);

  final TextStyle estilo;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Resumen Anual de ${user!.displayName} ',
          style: estilo,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Ganancias',
              style: estilo,
            ),
            Text(
              'L. 9500',
              style: estilo,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ChartWidget(),
        Container(
            //color: Colors.red,
            alignment: Alignment.center,
            height: 70,
            width: 200,
            child: Text(
              'Ofertas',
              style: estilo,
            ))
      ],
    );
  }
}
