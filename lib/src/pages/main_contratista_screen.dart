import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Propuesta.dart';
import 'package:hm_help/src/pages/upload_propuesta.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/provider/listaContratista_provider.dart';
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
      ContenedorGrafico(estilo: estilos.estilo,),
      Expanded(child: Container(
      decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.only(top: 10),
      child: StreamBuilder<List<Propuesta>>(
      stream: propuestasProvider.propuestasStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
        return RefreshIndicator(
          onRefresh: () {
          propuestasProvider.montoTotal();
          propuestasProvider.gananciasPorMes();
        return propuestasProvider.getPropuestas();},
          child: buildListaOfertas(
          snapshot, propuestasProvider, estilos),
  );
        } else {
        return Center(child: CircularProgressIndicator());
  }
  },
  ),
  ),
  )
  ],
  ),
  ),
  );
  }

  ListView buildListaOfertas(AsyncSnapshot<List<Propuesta>> snapshot,
    PropuestasProvider propuestasProvider, Styles estilos) {
    return ListView.separated(
      separatorBuilder: (context, index) {
    return Divider(
      color: Colors.white,
      thickness: 1.4,
      endIndent: 4,
      indent: 4,
  );
  },
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
      List<Propuesta> propuestas = snapshot.data!.toList();
        return Container(
          decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: TileOferta(
          funcion: propuestasProvider.recargar,
          propuesta: propuestas[index],
          estilo: estilos.estiloWhite,
  ),
  );
  }
  );
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
            barrierDismissible: true,
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
      leading: FutureBuilder<String?>(
        future: ContratistasProvider()
            .contratistaImageURL(propuesta.nombreContratista!),
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                    color: Colors.blue.shade300,
                    image: new DecorationImage(
                      image: new NetworkImage(snapshot.data!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                    border: new Border.all(
                      color: Colors.blue.shade300,
                      width: 4.0,
                    ),
                  ),
                )
              : CircularProgressIndicator();
        },
      ),
      title: Text(
        '${propuesta.nombre}',
        style: estilo,
      ),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Resumen Anual de ${preferenciasUsuario.nombreUsuario}',
              style: estilo,
            ),
            InkWell(
              focusColor: Colors.blue,
              highlightColor: Colors.black,
              splashColor: Colors.blue,
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                  color: Colors.blue.shade300,
                  image: new DecorationImage(
                    image: new NetworkImage(preferenciasUsuario.imageUsuario),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.blue.shade300,
                    width: 4.0,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'userProfile');
              },
            ),
          ],
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
            Container(
              child: StreamBuilder<String>(
                  stream: propuestasProvider.montoTotal(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.connectionState);
                      return GananciasText(snapshot: snapshot);
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<List<MesAgrupado>>(
            stream: propuestasProvider.gananciasPorMes(),
            builder: (context, snapshot) {
              if (snapshot.data!.length == 0) {
                return Center(
                    child: Text(
                  'No hay ganacias reportadas este año.',
                  style: new Styles().estilo.copyWith(fontSize: 15),
                ));
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ChartWidget(snapshot: snapshot);
              } else {
                return CircularProgressIndicator();
              }
            }),
        Container(
            alignment: Alignment.center,
            height: 70,
            width: 200,
            child: Text(
              'Ofertas',
              style: estilo,
            )),
      ],
    );
  }
}
