import 'package:flutter/material.dart';
import 'package:hm_help/src/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class MenuPrincipal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final uiProvider = Provider.of<UiProvider>(context);
  final currentIndex = uiProvider.seleccionarPagina;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.seleccionarPagina = i,
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Inicio",
  ),
        BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: "Mensajes",
  ),
  ],
  );
  }
}