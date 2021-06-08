import 'package:flutter/cupertino.dart';

class lineChartProvider extends ChangeNotifier {
  int? _maximo;

  lineChartProvider() {
    _maximo = 0;
  }

  int get maximoGanancia => _maximo!;

  set maximoGanancia(int maximo) {
    _maximo = maximo;
    notifyListeners();
  }
}
