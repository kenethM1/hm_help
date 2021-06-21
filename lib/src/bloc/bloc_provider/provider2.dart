import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/bloc_files/logupBlock.dart';


class Provider2 extends InheritedWidget {
  final logupBloc = LogupBloc();

  Provider2({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LogupBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider2>()!.logupBloc;
  }
}
