import 'dart:async';

import 'package:hm_help/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validator{
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  //Recuperar datos del stream

  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  //Stream<bool> get formValidStream => 
  //Insertar valores al stream

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
