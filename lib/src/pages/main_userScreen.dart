import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hm_help/src/components/Carrusel.dart';
import 'package:hm_help/src/components/Menu.dart';
import 'package:hm_help/src/provider/listaContratista_provider.dart';
import 'package:hm_help/src/components/listaContratistas.dart';
import 'package:hm_help/src/models/Usuario.dart';

class MainUsuarioScreen extends StatelessWidget {
  final menuBar = Menu();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Inicio",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Ajustes",
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              _barraBusqueda(),
              _tituloCategorias(context),
              _tituloContratista(context),
            ],
          ),
        ));
  }

  Widget _barraBusqueda() {
    final MainAxisAlignment mainAxisAlignment;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        children: <Widget>[
          IconButton(
            iconSize: 40.0,
            icon: SvgPicture.asset('assets/icons/icons8-search.svg'),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 40.0,
            icon: SvgPicture.asset('assets/icons/icons8-settings.svg'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _tituloCategorias(context) {
    return Column(
      children: <Widget>[
        Text(
          'CATEGORIAS',
          style: Theme.of(context).textTheme.headline5,
        ),
        ListaCategorias(),
      ],
    );
  }

  Widget _tituloContratista(context) {
    final contratistasProvider = new ContratistasProvider();
    contratistasProvider.getContratista();
    return Column(
      children: <Widget>[
        Text(
          'CONTRATISTAS',
          style: Theme.of(context).textTheme.headline5,
        ),
        StreamBuilder<List<Contratista>>(
          stream: contratistasProvider.contratistaStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    List<Contratista> contratista = snapshot.data!.toList();
                    return ListaContratista(contratista: contratista[index]);
                  });
            } else {
              print(snapshot.connectionState);
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  Widget _menuBar(context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Ajustes",
          ),
        ],
      ),
    );
  }
}
