import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/bloc_files/logupBlock.dart';


class Proveedor extends InheritedWidget {
  final logupBloc = LogupBloc();

  Proveedor({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LogupBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Proveedor>()!.logupBloc;
  }
}
