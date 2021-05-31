//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Propuesta.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/styles/Styles.dart';
import 'package:hm_help/src/widgets/Ganancias_widget.dart';
import 'package:hm_help/src/widgets/Line_Chart.dart';
import 'package:hm_help/src/widgets/Propuesta_Dialog.dart';

class MainContratistaScreen extends StatelessWidget {
  const MainContratistaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propuestasProvider = new PropuestasProvider();
    final estilos = new Styles();

    propuestasProvider.getPropuestas();
    propuestasProvider.montoTotal();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ContenedorGrafico(estilo: estilos.estilo),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: StreamBuilder<List<Propuesta>>(
                  stream: propuestasProvider.propuestasStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RefreshIndicator(
                        onRefresh: () {
                          propuestasProvider.montoTotal();
                          propuestasProvider.gananciasPorMes();
                          return propuestasProvider.getPropuestas();
                        },
                        child: buildListaOfertas(
                            snapshot, propuestasProvider, estilos),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                color: Colors.blue.shade200,
              ),
            )
          ],
        ),
      ),
    );
  }

  ListView buildListaOfertas(AsyncSnapshot<List<Propuesta>> snapshot,
      PropuestasProvider propuestasProvider, Styles estilos) {
    return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          List<Propuesta> propuestas = snapshot.data!.toList();
          return TileOferta(
            funcion: propuestasProvider.recargar,
            propuesta: propuestas[index],
            estilo: estilos.estiloWhite,
          );
        });
  }
}

class TileOferta extends StatelessWidget {
  const TileOferta({
    Key? key,
    required this.propuesta,
    required this.estilo,
    required this.funcion,
  }) : super(key: key);
  final Propuesta propuesta;
  final TextStyle estilo;
  final Function funcion;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Colors.blue,
      onTap: () {
        showDialog(
            barrierColor: Color.fromRGBO(135, 206, 235, 90),
            context: context,
            builder: (context) {
              return PropuestaDialog(
                recargar: funcion,
                propuestaList: propuesta,
              );
            });
      },
      subtitle: Text(
        propuesta.rubro.toString(),
        style: estilo.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
      ),
      leading: Icon(
        Icons.person,
        size: 50,
      ),
      title: Text(
        '${propuesta.nombre}',
        style: estilo,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TrailingButton(
            color: Colors.blue,
            texto: "ACEPTAR",
          ),
          TrailingButton(color: Colors.red, texto: "RECHAZAR")
        ],
      ),
    );
  }
}

class TrailingButton extends StatelessWidget {
  const TrailingButton({
    Key? key,
    required this.texto,
    required this.color,
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
      child: Text(texto!),
      onPressed: () {},
    );
  }
}

class ContenedorGrafico extends StatelessWidget {
  const ContenedorGrafico({
    Key? key,
    required this.estilo,
  }) : super(key: key);

  final TextStyle estilo;

  @override
  Widget build(BuildContext context) {
    final preferenciasUsuario = new PreferenciasUsuario();
    final propuestasProvider = new PropuestasProvider();

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Resumen Anual de ${preferenciasUsuario.nombreUsuario}',
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
            StreamBuilder<String>(
                stream: propuestasProvider.propuestasTotalStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GananciasText(snapshot: snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ChartWidget(),
        Container(
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
