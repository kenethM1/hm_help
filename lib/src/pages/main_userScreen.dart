import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hm_help/src/components/Carrusel.dart';
import 'package:hm_help/src/provider/listaContratista_provider.dart';
import 'package:hm_help/src/components/listaContratistas.dart';
import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/styles/Styles.dart';

class MainUsuarioScreen extends StatelessWidget {
/*
  showSimpleDialog(BuildContext context){
    TextEditingController customController = TextEditingController();

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Contratista"),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text("data"),
            onPressed: (){},
          )
        ],
      );
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _barraBusqueda(),
            //  _bienvenida(),
            _tituloCategorias(context),
            _tituloContratista(context),
          ],
        ),
      ),
    );
  }

  Widget _barraBusqueda() {
    final MainAxisAlignment mainAxisAlignment;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            iconSize: 40.0,
            icon: SvgPicture.asset('assets/icons/icons8-settings.svg'),
            onPressed: () {},
          ),
          Image(
            image: AssetImage('assets/logo.png'),
            height: 50,
            width: 50,
          )
          /* IconButton(
            iconSize: 40.0,
            icon: AssetImage('assets/logo.png'),
            onPressed: () {},
          ),*/
        ],
      ),
    );
  }

  Widget _tituloCategorias(context) {
    return Column(
      children: <Widget>[
        Text(
          'CATEGORIAS',
          style: new Styles().estilo,
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
        StreamBuilder<List<Usuario>>(
          stream: contratistasProvider.contratistaStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List<Usuario> contratista = snapshot.data!.toList();
                      return ListaContratista(contratista: contratista[index]);
                    }),
              );
            } else {
              print(snapshot.connectionState);
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
