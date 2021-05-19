import 'package:flutter/material.dart';
import 'package:hm_help/src/models/propuesta.dart';
import 'package:hm_help/src/pages/main_contratista_screen.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:hm_help/src/styles/Styles.dart';

class ListaPropuestas extends StatelessWidget {
  const ListaPropuestas({
    Key? key,
    required this.snapshot,
    required this.context,
  }) : super(key: key);

  final AsyncSnapshot snapshot;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final estilos = new Styles();
    final propuestasProvider = new PropuestasProvider();

    return RefreshIndicator(
      onRefresh: () {
        return propuestasProvider.getPropuestas();
      },
      child: ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            List<Propuesta> propuestas = snapshot.data!.toSet().toList();
            return TileOferta(
              funcion: propuestasProvider.recargar,
              propuesta: propuestas[index],
              estilo: estilos.estiloWhite,
            );
          }),
    );
  }
}
