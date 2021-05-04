import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registo del Contratista'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearCorreo(),
          Divider(),
          _crearContrasena(),
          Divider(),
          _crearFecha(context),
          Divider(),
        ],
      ),
    );
  }

  _crearCorreo() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: 'Ingresar correo',
        labelText: 'No utilizado antes',

        //Iconos
        suffixIcon: Icon(Icons.alternate_email_outlined),
        icon: Icon(Icons.email_rounded),
      ),
    );
  }

  _crearContrasena() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
          helperText: 'Incluya mayusculas y minusculas',
          suffixIcon: Icon(Icons.lock_open_rounded),
          icon: Icon(Icons.lock_rounded)),
    );
  }

  _crearFecha(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
          suffixIcon: Icon(Icons.perm_contact_calendar_rounded),
          icon: Icon(Icons.calendar_today_rounded)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _seleccionarFecha(context);
      },
    );
  }

  _seleccionarFecha(BuildContext context) async {
    DateTime? seleccionado = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2040),

        //Idioma
        locale: Locale('es'));
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      color: Colors.blue.shade300,
      child: Image(
        height: 20,
        width: 25,
        image: AssetImage('assets/logo.png'),
        //fit: BoxFit.contain,
      ),
    );
  }
}
