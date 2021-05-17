import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:hm_help/src/bloc/bloc_validators/validators.dart';

class LogupBloc with Validator {
  final _nombreController = BehaviorSubject<String>();
  final _apellidoController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get nombreStream => _emailController.stream;
  Stream<String> get apellidoStream => _apellidoController.stream;
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changeApellido => _apellidoController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String? get nombre => _nombreController.value;
  String? get apellido => _apellidoController.value;
  String? get email => _emailController.value;
  String? get password => _passwordController.value;

  dispose() {
    _nombreController.close();
    _apellidoController.close();
    _emailController.close();
    _passwordController.close();
  }
}
