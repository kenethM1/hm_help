import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/bloc_files/login_bloc.dart';
import 'package:hm_help/src/bloc/bloc_provider/provider.dart';
import 'package:hm_help/src/pages/logup_screen.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/provider/images_provider.dart';
import 'package:hm_help/src/provider/usuario_provider.dart';
import 'package:hm_help/src/widgets/AlertLogin_Dialog.dart';
import 'package:hm_help/src/widgets/campoContrasena.dart';
import 'package:hm_help/src/widgets/registro_usuario_contratista.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade300,
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
    final bloc = ProviderBloc.of(context);

    return Container(
        height: 600,
        color: Colors.white,
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          _usuario(bloc),
          _password(bloc),
          SizedBox(
            height: 30,
          ),
          _loginButton(bloc),
          TextButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return SignUpDecide();
                  }),
              child: Text(
                '¿No tienes cuenta? Registrate!',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ]));
  }
}

class ForgetPassButton extends StatelessWidget {
  const ForgetPassButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => LogupUsuario()));
        },
        child: Text(
          '¿No tienes cuenta? Registrate!',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ));
  }
}

Widget _loginButton(LoginBloc bloc) {
  return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (context, snapshot) {
        return Container(
          width: 230,
          height: 50,
          child: ElevatedButton(
              child: Text('Iniciar Sesion'),
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: StadiumBorder(),
                  textStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onPressed: snapshot.hasData
                  ? () {
                      _login(bloc, context);
                      showDialog(
                        context: (context),
                        builder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  : null),
        );
      });
}

_login(LoginBloc bloc, BuildContext context) async {
  final usuarioProvider = new UsuarioProvider();
  final preferenciasUsuario = PreferenciasUsuario();

  Map respuesta = await usuarioProvider.login(
      bloc.email.toString(), bloc.password.toString());

  final provider = Provider.of<ImagesProvider>(context, listen: false);

  if (respuesta['ok'] == true && respuesta['rol'] == 'Contratista') {
    provider.changeProfileImg = respuesta['imageURL'];
    Navigator.pushNamed(context, 'principal');
  } else if (respuesta['ok'] == true && respuesta['rol'] == 'Usuario') {
    provider.changeProfileImg = respuesta['imageURL'];
    Navigator.pushNamed(context, 'mainUser');
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AlertLogin(
            titulo: 'Error',
            mensaje: 'Correo o contraseña no válidos.',
          );
        });
  }
}

Widget _password(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: CampoPersonalizado(
            isEmail: false,
            bloc: bloc,
            isObscure: true,
            texto: 'Contraseña',
          ));
    },
  );
}

Widget _usuario(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: CampoPersonalizado(
              isEmail: true, bloc: bloc, isObscure: false, texto: 'Email'));
    },
  );
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              color: Colors.grey,
              spreadRadius: 2,
              offset: Offset(0, 1))
        ],
        color: Colors.blue,
      ),
      height: 360,
      width: double.infinity,
      child: Image(
        height: 250,
        width: 250,
        image: AssetImage('assets/logo.png'),
      ),
    );
  }
}
