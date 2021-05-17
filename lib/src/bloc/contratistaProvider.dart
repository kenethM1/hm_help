import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/contratista_bloc.dart';
export 'package:hm_help/src/bloc/contratista_bloc.dart';

class ProviderContratista extends InheritedWidget {
  final contratistaBloc = ContratistaBloc();

  ProviderContratista({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static ContratistaBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderContratista>()!
        .contratistaBloc;
  }
}
