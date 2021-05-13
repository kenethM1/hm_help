import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/models/propuesta.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/widgets/line_chart.dart';
import 'package:hm_help/src/widgets/propuesta_dialog.dart';

class MainContratistaScreen extends StatelessWidget {
  const MainContratistaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propuestasProvider = new PropuestasProvider();

    propuestasProvider.getPropuestas();

    var tamano = MediaQuery.of(context).size;

    TextStyle estilo = TextStyle(
        color: Colors.blue.shade200, fontSize: 24, fontWeight: FontWeight.bold);

    TextStyle estiloWhite = TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ContenedorGrafico(estilo: estilo),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: StreamBuilder<List<Propuesta>>(
                stream: propuestasProvider.propuestasStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          if (snapshot.hasData) {
                            return TileOferta(
                              estiloWhite: estiloWhite,
                              nombre: snapshot.data![index].nombreUsuario,
                              rubro: snapshot.data![index].rubro,
                              monto: snapshot.data![index].monto,
                              info: snapshot.data![index].descripcion,
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
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

class TileOferta extends StatelessWidget {
  const TileOferta({
    Key? key,
    required this.estiloWhite,
    required this.nombre,
    required this.rubro,
    required this.monto,
    required this.info,
  }) : super(key: key);

  final TextStyle estiloWhite;
  final String? nombre;
  final String? rubro;
  final double? monto;
  final String? info;
  get nombreCliente => nombre!.split(' ');
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
                nombreCliente: nombre!,
                monto: monto!,
                info: this.info.toString(),
              );
            });
      },
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
        nombreCliente[0].toString(),
        style: estiloWhite,
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

    //final user = FirebaseAuth.instance.currentUser;

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
