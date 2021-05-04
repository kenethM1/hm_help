import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hm_help/src/bloc/login_bloc.dart';
import 'package:hm_help/src/bloc/logup_bloc.dart';
import 'package:hm_help/src/bloc/provider.dart';
import 'package:hm_help/src/provider/usuario_provider.dart';

class LogUPScreen extends StatelessWidget {
  

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
    final bloc = Provider.of(context);

    return Container(
        height: 600,
        color: Colors.white,
        child: Column(children: [
          _usuario(bloc),
          _passWord(bloc),
          SizedBox(
            height: 30,
          ),
          _logUP_button(bloc),
        ]));
  }
}

// ignore: camel_case_types


Widget _logUP_button(LoginBloc bloc) {
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
              onPressed: snapshot.hasData ? () => _logUP(bloc, context) : null),
        );
      });
}

_logUP(LoginBloc bloc, BuildContext context) async {
  final usuarioProvider = new UsuarioProvider();

  print(bloc.email);
  print(bloc.password);
  Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);

  if (info['ok']) {
    Navigator.pushNamed(context, 'registro');
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("El correo ya esta en uso"),
            elevation: 3,
            content: Text('Ingrese un correo nuevo'),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Okay'))
            ],
          );
        });
  }
}

Widget _passWord(LoginBloc bloc) {
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

Widget _user(LoginBloc bloc) {

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
              hintText: 'Usuario',
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
                  onChanged: (value) => bloc.changeEmail(value),
        ),
      );
    },
  );
}

Widget _usuario(LoginBloc bloc) {
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
