import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistroPage extends StatefulWidget {
  @override
  _registroState createState() => _registroState();
}

class _registroState extends State<RegistroPage> {
  String _fecha = '';
  String _nombre = '';
  TextEditingController _relacionFecha = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registo del Contratista'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(left: 8.0),
            child: Image(
              height: 90,
              width: 90,
              image: AssetImage('assets/logo.png'),
              //fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearNombre(),
          Divider(),
          _crearCorreo(),
          Divider(),
          _crearContrasena(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearBoton(context),
          Divider(),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Text('Terminos y condiciones'),
            onPressed: () => _mostrarAlert(context),
            color: Colors.blue,
            textColor: Colors.white,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.first_page_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Agregar CV'),
      icon: Icon(Icons.article_outlined),
      onPressed: () => Navigator.pushNamed(context, 'hojaVida'),
    );
  }

  _crearNombre() {
    return TextField(
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          counter: Text('Letras ${_nombre.length}'),
          hintText: 'Ingrese su nombre',
          labelText: 'Nombre',
          helperText: 'Solo el nombre',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
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
      controller: _relacionFecha,
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
      // locale: Locale('es')
    );

    if (seleccionado != null) {
      setState(() {
        _fecha = seleccionado.toString();
        _relacionFecha.text = _fecha;
      });
    }
  }
}

void _mostrarAlert(BuildContext context) {
  showDialog(
      context: context,
      barrierColor: Colors.blue.shade400,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          //Shape: Para colocar el borde
          //
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          backgroundColor: Colors.blue,
          title: Text('Terminos HMHelp'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  'HMHelp accedera a su curriculm con el fin de ayudarle y ayudar a las personas que necesiten de sus servicios'),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Image(
                  height: 50,
                  width: 50,
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              textColor: Colors.black,
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Aceptar'),
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
