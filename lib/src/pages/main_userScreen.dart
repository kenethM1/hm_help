import 'package:flutter/material.dart';
import 'package:hm_help/src/components/Carrusel.dart';
import 'package:hm_help/src/provider/listaContratista_provider.dart';
import 'package:hm_help/src/components/listaContratistas.dart';
import 'package:hm_help/src/models/Usuario.dart';


class MainUsuarioScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: ListView(
      children: <Widget>[
         _tituloCategorias(context),
        _tituloContratista(context),
    ],
    ),
    ),
    );
  }

  Widget _barraBusqueda(BuildContext context) {
    final MainAxisAlignment mainAxisAlignment;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      PopupMenuButton(
        onSelected: (result){
        if(result == 0){
          Navigator.pushNamed(context, 'login');
          }
          },
      itemBuilder: (context) => [
      PopupMenuItem(
        value: 0,
        child: 
      Row(children: [
      Icon(Icons.logout),
      Text("Cerrar Sesion"),
  ],
  ),
  ),
  ],
      child: Icon(
      Icons.settings,
      size: 30,
  ),
  ),
      Image(image: AssetImage('assets/logo.png'),
      height: 50,
      width: 50,
  )
  ],
  ),
  );
  }



  Widget _tituloCategorias(context) {
    return Column(
    children: <Widget>[
      Text('CATEGORIAS',
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
      Text('CONTRATISTAS',
      style: Theme.of(context).textTheme.headline5,),
      StreamBuilder<List<Contratista>>(
      stream: contratistasProvider.contratistaStream,
        builder: (context, snapshot) {
        if (snapshot.hasData) {
        return SingleChildScrollView(
        child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),                 
        shrinkWrap: true,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          List<Contratista> contratista = snapshot.data!.toList();
          return ListaContratista(contratista: contratista[index]);
  }
  ),
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
