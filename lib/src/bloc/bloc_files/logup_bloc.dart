import 'dart:async';

import 'package:hm_help/src/bloc/bloc_validators/RegistroValidator.dart';
import 'package:rxdart/rxdart.dart';

class LogupBloc with Validator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar datos del stream

  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Insertar valores al stream

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get email => _emailController.toString();
  String get password => _passwordController.toString();

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
