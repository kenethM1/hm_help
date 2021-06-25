import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hm_help/src/bloc/bloc_files/contratista_bloc.dart';
import 'package:hm_help/src/bloc/bloc_provider/contratistaProvider.dart';
import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/provider/contratista_Provider.dart';
import 'package:hm_help/src/widgets/contratistaDialog.dart';

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

  static const generos = <String>['Masculino', 'Femenino'];
  String generoSeleccionado = generos.first;

  TextEditingController _relacionFecha = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bloc = ProviderContratista.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
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
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Registo de los Contratistas',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _crearNombre(bloc),
            Divider(color: Colors.blueAccent),
            _crearApellido(bloc),
            Divider(color: Colors.blueAccent),
            _crearFecha(context, bloc),
            Divider(color: Colors.blueAccent),
            _crearCorreo(bloc),
            Divider(color: Colors.blueAccent),
            _crearContrasena(bloc),
            Divider(color: Colors.blueAccent),
            _crearGenero(),
            Divider(color: Colors.blueAccent),
            _crearbuildRadios(context, bloc),
            Divider(color: Colors.blueAccent),
            _crearBoton(context),
            Divider(color: Colors.blueAccent),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: SizedBox(
                height: 35,
                width: 230,
                child: ElevatedButton(
                  child: Text('Terminos y condiciones'),
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onPressed: () => _mostrarAlert(context),
                ),
              ),
            ),
            Divider(),
            _crearGuardar(bloc),
            SizedBox(height: 10),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox(
        height: 35,
        width: 230,
        child: ElevatedButton.icon(
          label: Text('Agregar CV'),
          icon: Icon(Icons.picture_as_pdf_rounded),
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          onPressed: () => Navigator.pushNamed(context, 'hojaVida'),
        ),
      ),
    );
  }

  Widget _crearGuardar(ContratistaBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: SizedBox(
            height: 35,
            width: 230,
            child: ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text('Guardar'),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onPressed: snapshot.hasData
                    ? () => _contratista(bloc, context)
                    : null),
          ),
        );
      },
    );
  }

  _contratista(ContratistaBloc bloc, BuildContext context) async {
    final contratistaProvider = ContratistaProvider();
    Usuario usuario = new Usuario(
        nombre: bloc.nombre.toString(),
        correo: bloc.correo.toString(),
        apellido: bloc.apellido.toString(),
        fechaNacimiento: bloc.fecha.toString(),
        sexo: bloc.genero.toString());

    Map info = await contratistaProvider.nuevoContratista(
        usuario, bloc.contra.toString());

        

    if (info['ok'] == true) {
      Navigator.pushNamed(context, 'principal');
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertLoginContratista(
              mensaje: 'No se pudo hacer el registro',
              titulo: 'Datos incompletos',
            );
          });
    }
  }

  _crearNombre(ContratistaBloc bloc) {
    return StreamBuilder(
      stream: bloc.nombreStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          margin: EdgeInsets.all(4),
          child: TextField(
            autofocus: false,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: 'Ingrese sus nombres',
                labelText: 'Nombre',
                suffixIcon: Icon(Icons.assignment_ind_rounded),
                icon: Icon(Icons.group_outlined)),
            onChanged: bloc.changeNombre,
          ),
        );
      },
    );
  }

  _crearApellido(ContratistaBloc bloc) {
    return StreamBuilder(
      stream: bloc.apellidoStram,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          margin: EdgeInsets.all(4),
          child: TextField(
            autofocus: false,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: 'Ingrese sus apellidos',
                labelText: 'Apellido',
                suffixIcon: Icon(Icons.assignment_ind_rounded),
                icon: Icon(Icons.group_outlined)),
            onChanged: bloc.changeApellido,
          ),
        );
      },
    );
  }

  _crearCorreo(ContratistaBloc bloc) {
    return StreamBuilder(
      stream: bloc.correoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          margin: EdgeInsets.all(4),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              hintText: 'Ingrese su correo',
              labelText: 'No utilizado antes',
              suffixIcon: Icon(Icons.contact_mail_rounded),
              icon: Icon(Icons.attach_email_rounded),
            ),
            onChanged: bloc.changeCorreo,
          ),
        );
      },
    );
  }

  _crearContrasena(ContratistaBloc bloc) {
    return StreamBuilder(
      stream: bloc.contrasenaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          margin: EdgeInsets.all(4),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: 'Ingrese su contraseña',
                labelText: 'Incluya mayusculas y minusculas por su seguridad',
                suffixIcon: Icon(Icons.lock_open_rounded),
                icon: Icon(Icons.lock_rounded)),
            onChanged: bloc.changeContrasena,
          ),
        );
      },
    );
  }

  _crearFecha(BuildContext context, ContratistaBloc bloc) {
    return Container(
      margin: EdgeInsets.all(4),
      child: TextField(
        enableInteractiveSelection: false,
        controller: _relacionFecha,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: 'Fecha de nacimiento',
            labelText: 'Fecha de nacimiento',
            suffixIcon: Icon(Icons.cake_rounded),
            icon: Icon(Icons.calendar_today_rounded)),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _seleccionarFecha(context, bloc);
        },
      ),
    );
  }

  _seleccionarFecha(BuildContext context, ContratistaBloc bloc) async {
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
        bloc.changeFecha(_fecha);
      });
    }
  }

  _crearGenero() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'Seleccione genero',
            style: TextStyle(fontSize: 15.0),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  Widget _crearbuildRadios(BuildContext context, ContratistaBloc bloc) {
    return StreamBuilder(
      stream: bloc.generoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Column(
          children: generos.map(
            (genero) {
              return RadioListTile(
                value: genero,
                groupValue: generoSeleccionado,
                title: Text(
                  genero,
                  style: TextStyle(),
                ),
                onChanged: (value) => setState(() {
                  this.generoSeleccionado = genero;
                  bloc.changeGenero(this.generoSeleccionado);
                }),
              );
            },
          ).toList(),
        );
      },
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
