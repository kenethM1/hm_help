import 'package:flutter/material.dart';
import 'package:hm_help/src/pages/main_userScreen.dart';
import 'package:hm_help/src/pages/mensajes_page.dart';
import 'package:hm_help/src/provider/ui_provider.dart';
import 'package:hm_help/src/widgets/menuBar.dart';
import 'package:provider/provider.dart';


class HomePageUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: HomeBody(),
      bottomNavigationBar: MenuPrincipal(),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.seleccionarPagina;

    switch(currentIndex)
    {
      case 0: return MainUsuarioScreen();
      case 1: return MensajePage();
      default: return MainUsuarioScreen();
    }

  }
}