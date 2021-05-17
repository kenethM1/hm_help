import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hm_help/src/bloc/login_bloc.dart';
import 'package:hm_help/src/bloc/provider.dart';
import 'package:hm_help/src/provider/GoogleSignIn_Provider.dart';
import 'package:hm_help/src/provider/usuario_provider.dart';
import 'package:hm_help/src/widgets/alertLogin_dialog.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
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
    final bloc = ProviderBloc.of(context);

    return Container(
        height: 600,
        color: Colors.white,
        child: Column(children: [
          _usuario(bloc),
          _password(bloc),
          PasswordRecoveryButton(),
          SizedBox(
            height: 30,
          ),
          _loginButton(bloc),
          ChangeNotifierProvider<GoogleSignInProvider>(
              create: (context) => GoogleSignInProvider(),
              child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  final provider = Provider.of<GoogleSignInProvider>(context);
                  if (snapshot.hasData) {
                    Navigator.pushNamed(context, 'principal');
                  } else {
                    return SocialSignInButton();
                  }
                  return Text('');
                },
              )),
          TextButton(
              onPressed: () => Navigator.pushNamed(context, 'nuevoUser'),
              child: Text(
                '¿No tienes cuenta? Registrate!',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ]));
  }

  ChangeNotifierProvider<GoogleSignInProvider> googlesigninButton() {
    return ChangeNotifierProvider<GoogleSignInProvider>(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Navigator.pushNamed(context, 'principal');
            } else {
              return SocialSignInButton();
            }
            return Text('');
          },
        ));
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
              new MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Text(
          '¿No tienes cuenta? Registrate!',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ));
  }
}

class SocialSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        margin: EdgeInsets.only(left: 30),
        child: SignInButton(Buttons.Google, elevation: 0, onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.login();
        }),
      ),
    );
  }
}

class PasswordRecoveryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(primary: Colors.grey.shade500),
        child: Text('Olvidaste tu contraseña?'));
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
                  shape: StadiumBorder(),
                  textStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onPressed: snapshot.hasData ? () => _login(bloc, context) : null),
        );
      });
}

_login(LoginBloc bloc, BuildContext context) async {
  final usuarioProvider = new UsuarioProvider();

  print(bloc.email);
  print(bloc.password);
  Map info = await usuarioProvider.login(
      bloc.email.toString(), bloc.password.toString());

  if (info['ok'] == true && info['rol'] == 'Contratista') {
    Navigator.pushNamed(context, 'principal-Contratista');
  } else if (info['ok'] == true && info['rol'] == 'Usuario') {
    showDialog(
        context: context,
        builder: (context) {
          return AlertLogin(
            titulo: 'Ingresó',
            mensaje: 'Usted es un usuario.',
          );
        });
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
