import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistroPage extends StatefulWidget {
  @override
  _registroState createState() => _registroState();
}

bool textoobs = true;
@override
void initState() {
  textoobs = false;
}

class _registroState extends State<RegistroPage> {
  String _fecha = '';
  String _nombre = '';

  TextEditingController _relacionFecha = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registo del Contratista'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(left: 8.0),
            child: Image(
              height: 90,
              width: 90,
              image: AssetImage('assets/logo.png'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _crearNombre(),
          Divider(),
          _crearApellido(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearCorreo(),
          Divider(),
          _crearContrasena(textoobs),
          Divider(),
          _crearGenero(),
          Divider(),
          _crearBoton(context),
          ElevatedButton(
            child: Text('Terminos y condiciones'),
            style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                textStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onPressed: () => _mostrarAlert(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.first_page_rounded),
        onPressed: () {
          Navigator.pushNamed(context, 'login');
        },
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return ElevatedButton.icon(
      label: Text('Agregar CV'),
      icon: Icon(Icons.picture_as_pdf_rounded),
      style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
          helperText: 'Agregue su nombre',
          suffixIcon: Icon(Icons.assignment_ind_rounded),
          icon: Icon(Icons.group_outlined)),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  _crearApellido() {
    return TextField(
      autofocus: false,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          counter: Text('Letras ${_nombre.length}'),
          hintText: 'Ingrese su nombre',
          labelText: 'Apellido',
          helperText: 'Agregue su apellido',
          suffixIcon: Icon(Icons.assignment_ind_rounded),
          icon: Icon(Icons.group_outlined)),
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
        suffixIcon: Icon(Icons.contact_mail_rounded),
        icon: Icon(Icons.attach_email_rounded),
      ),
    );
  }

  _crearContrasena(bool isobscure) {
    return TextField(
        obscureText: isobscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
          helperText: 'Incluya mayusculas y minusculas',
          suffixIcon: Icon(Icons.lock_open_rounded),
          icon: IconButton(
            icon: Icon(
                isobscure ? Icons.visibility : Icons.visibility_off_rounded),
            onPressed: () => {
              setState(() {
                isobscure = !isobscure;
              })
            },
          ),
        ));
  }

  _crearFecha(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _relacionFecha,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintText: 'Fecha de nacimiento',
          labelText: 'Fecha de nacimiento',
          suffixIcon: Icon(Icons.cake_rounded),
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
    );

    if (seleccionado != null) {
      setState(() {
        _fecha = seleccionado.toString();
        _relacionFecha.text = _fecha;
      });
    }
  }

  _crearGenero() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          labelText: 'Genero',
          suffixIcon: Icon(Icons.wc_rounded),
          icon: Icon(Icons.wc_rounded)),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 30.0;
}

void _mostrarAlert(BuildContext context) {
  showDialog(
      context: context,
      barrierColor: Colors.blue.shade400,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: Colors.blue,
          title: Text('Terminos HMHelp'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  'HMHelp accedera a su curriculm con el fin de ayudarle y ayudar a las personas que necesiten de sus servicios'),
              Container(
                padding: EdgeInsets.all(20.0),
              ),
              Positioned(
                left: Consts.padding,
                right: Consts.padding,
                child: Image(
                  height: 150,
                  width: 120,
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              style: TextButton.styleFrom(
                primary: Colors.black87,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Aceptar'),
              style: TextButton.styleFrom(
                primary: Colors.black87,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
