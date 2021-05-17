import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/bloc_files/login_bloc.dart';

class CampoPersonalizado extends StatelessWidget {
  CampoPersonalizado(
      {Key? key,
      required this.bloc,
      required this.isObscure,
      required this.texto})
      : super(key: key);

  LoginBloc bloc;
  bool isObscure;
  String texto;

  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPadding: EdgeInsets.only(bottom: 15),
      autocorrect: false,
      obscureText: isObscure ? true : false,
      textAlign: TextAlign.center,
      onChanged: bloc.changePassword,
      decoration: InputDecoration(
          focusColor: Colors.blue,
          fillColor: Colors.grey.shade300,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: texto,
          hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 21,
              fontWeight: FontWeight.bold)),
    );
  }
}
