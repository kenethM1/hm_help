import 'package:flutter/material.dart';

import 'package:hm_help/src/bloc/bloc_provider/provider2.dart';

import 'package:hm_help/src/provider/usuario_provider.dart';

import 'package:hm_help/src/widgets/AlertLogin_Dialog.dart';

class LogupUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Logo(),
              _form(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context) {
    final bloc = Provider2.of(context);

    return Container(
        height: 600,
        color: Colors.white,
        child: Column(children: [
          _nombre(bloc),
          _apellido(bloc),
          _correo(bloc),
          _passWord(bloc),
          SizedBox(
            height: 30,
          ),
          _logup_button(bloc),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: Text(
                '¿Ya tienes cuenta? Inicia Sesion!',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ]));
  }
}

Widget _logup_button(LogupBloc bloc) {
  return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (context, snapshot) {
        return Container(
          width: 230,
          height: 50,
          child: ElevatedButton(
              child: Text('Registrate'),
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  textStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onPressed: snapshot.hasData ? () => _logup(bloc, context) : null),
        );
      });
}

_logup(LogupBloc bloc, BuildContext context) async {
  final usuarioProvider = new UsuarioProvider();

  print(bloc.email);
  print(bloc.password);
  print(bloc.nombre);
  print(bloc.apellido);
  Map info = await usuarioProvider.nuevoUsuario(
      bloc.nombre.toString(),
      bloc.apellido.toString(),
      bloc.email.toString(),
      bloc.password.toString());

  if (info['ok'] == true) {
    Navigator.pushNamed(context, 'principal');
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertLogin(
            titulo: 'Posible error',
            mensaje: 'Verifique sus datos',
          );
        });
  }
}

Widget _passWord(LogupBloc bloc) {
  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: TextField(
          scrollPadding: EdgeInsets.only(bottom: 15),
          autocorrect: false,
          obscureText: true,
          textAlign: TextAlign.center,
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
              focusColor: Colors.blue,
              fillColor: Colors.grey.shade300,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Contraseña',
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
        ),
      );
    },
  );
}

Widget _correo(LogupBloc bloc) {
  return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: TextField(
          scrollPadding: EdgeInsets.only(bottom: 15),
          autocorrect: false,
          //maxLength: 25,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              focusColor: Colors.blue,
              fillColor: Colors.grey.shade300,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Email',
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          onChanged: bloc.changeEmail,
        ),
      );
    },
  );
}

Widget _nombre(LogupBloc bloc) {
  return StreamBuilder(
    stream: bloc.nombreStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: TextField(
          scrollPadding: EdgeInsets.only(bottom: 15),
          autocorrect: false,
          //maxLength: 25,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              focusColor: Colors.blue,
              fillColor: Colors.grey.shade300,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Nombre',
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          onChanged: bloc.changeNombre,
        ),
      );
    },
  );
}

Widget _apellido(LogupBloc bloc) {
  return StreamBuilder(
    stream: bloc.apellidoStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: TextField(
          scrollPadding: EdgeInsets.only(bottom: 15),
          autocorrect: false,
          //maxLength: 25,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              focusColor: Colors.blue,
              fillColor: Colors.grey.shade300,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Apellido',
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          onChanged: bloc.changeApellido,
        ),
      );
    },
  );
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      color: Colors.blue.shade300,
      child: Image(
        height: 250,
        width: 250,
        image: AssetImage('assets/logo.png'),
        //fit: BoxFit.contain,
      ),
    );
  }
}
