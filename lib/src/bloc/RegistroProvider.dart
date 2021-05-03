import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/logup_bloc.dart';

class Provider extends InheritedWidget{

  final logupBloc = LogupBloc();

  Provider({Key key, Widget child})
  : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LogupBloc of ( BuildContext context ){
    return context.dependOnInheritedWidgetOfExactType<Provider>().logupBloc;
  }

}