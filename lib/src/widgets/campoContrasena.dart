import 'package:flutter/material.dart';
import 'package:hm_help/src/bloc/bloc_files/login_bloc.dart';

// ignore: must_be_immutable
class CampoPersonalizado extends StatefulWidget {
  CampoPersonalizado(
      {Key? key,
      required this.bloc,
      required this.isObscure,
      required this.isEmail,
      required this.texto})
      : super(key: key);

  LoginBloc bloc;
  bool isObscure;
  String texto;
  bool isEmail;

  @override
  _CampoPersonalizadoState createState() => _CampoPersonalizadoState();
}

class _CampoPersonalizadoState extends State<CampoPersonalizado> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPadding: EdgeInsets.only(),
      autocorrect: false,
      obscureText: widget.isObscure ? true : false,
      textAlign: TextAlign.center,
      onChanged:
          widget.isEmail ? widget.bloc.changeEmail : widget.bloc.changePassword,
      decoration: InputDecoration(
          suffix: (widget.isEmail
              ? null
              : IconButton(
                  onPressed: () {
                    widget.isObscure = !widget.isObscure;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    size: 20,
                    color: Colors.white,
                  ))),
          focusColor: Colors.blue,
          fillColor: Colors.grey.shade300,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: widget.texto,
          hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 21,
              fontWeight: FontWeight.bold)),
    );
  }
}
