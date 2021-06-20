import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:hm_help/src/bloc/bloc_validators/validators.dart';

class LogupBloc with Validator {
  final _emailController = BehaviorSubject<String>();
  final _nombreController = BehaviorSubject<String>();
  final _apellidoController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _sexoController = BehaviorSubject<String>();
  final _imagenController = BehaviorSubject<String>();
  final _fechaController = BehaviorSubject<String>();
  

  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get nombreStream => _emailController.stream;
  Stream<String> get apellidoStream => _apellidoController.stream;
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<String> get sexoStream => _sexoController.stream;
  Stream<String> get imagenStream => _imagenController.stream;
  Stream<String> get fechaStream => _fechaController.stream;
  

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changeApellido => _apellidoController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeSexo => _sexoController.sink.add;
  Function(String) get changeImagen => _imagenController.sink.add;
  Function(String) get changeFecha => _fechaController.sink.add;


  String? get email => _emailController.value;
  String? get nombre => _nombreController.value;
  String? get apellido => _apellidoController.value;
  String? get password => _passwordController.value;
  String? get sexo => _sexoController.value;
  String? get imagen => _imagenController.value;
  String? get fecha => _fechaController.value;
  

  dispose() {
    _emailController.close();
    _nombreController.close();
    _apellidoController.close();
    _passwordController.close();
    _sexoController.close();
    _imagenController.close();
    _fechaController.close();
    
    
  }
}
