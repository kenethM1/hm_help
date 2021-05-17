import 'dart:async';

class ValidatorContratista {
  final validarNombre = StreamTransformer<String, String>.fromHandlers(
      handleData: (nombre, sink) {
    if (nombre.length >= 5) {
      sink.add(nombre);
    } else {
      sink.addError('Nombre invalido , ingrese su nombre completo');
    }
  });

  final validarApellido = StreamTransformer<String, String>.fromHandlers(
      handleData: (apellido, sink) {
    if (apellido.length >= 2) {
      sink.add(apellido);
    } else {
      sink.addError('Apellido invalido , ingrese su apellido completo');
    }
  });

  final validarCorreo = StreamTransformer<String, String>.fromHandlers(
      handleData: (correo, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(pattern.toString());

    if (regExp.hasMatch(correo)) {
      sink.add(correo);
    } else {
      sink.addError('El correo es incorrecto');
    }
  });

  final validarContra = StreamTransformer<String, String>.fromHandlers(
      handleData: (contra, sink) {
    if (contra.length >= 8) {
      sink.add(contra);
    } else {
      sink.addError('Más de 8 caracteres');
    }
  });
}
