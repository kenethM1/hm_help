import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/login_bloc.dart';


class ProviderBloc extends InheritedWidget {
  final loginBloc = LoginBloc();


  ProviderBloc({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderBloc>()!
        .loginBloc;
  }
  }

