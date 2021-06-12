import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  
  int _seleccionarPagina = 0;

  int get seleccionarPagina {
    return this._seleccionarPagina;
  }

  set seleccionarPagina(int i){
    this._seleccionarPagina = i;
    notifyListeners();
  }
}