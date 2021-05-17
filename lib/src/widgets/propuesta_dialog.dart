import 'package:flutter/material.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';

class PropuestaDialog extends StatefulWidget {
  PropuestaDialog({
    Key? key,
    required this.nombreCliente,
    required this.monto,
    required this.info,
  }) : super(key: key);

  String nombreCliente = '';
  double monto = 0;
  String info;

  @override
  _PropuestaState createState() => _PropuestaState();
}

class _PropuestaState extends State<PropuestaDialog> {
  @override
  Widget build(BuildContext context) {
    final preferenciaUsuario = new PreferenciasUsuario();

    var textStyle = TextStyle(
        color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18);
    return SingleChildScrollView(
      child: Container(
        child: AlertDialog(
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.only(bottom: 150, top: 150),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 10,
          content: Container(
            height: 450,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                userInformacion(widget.nombreCliente, widget.monto),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Detalles',
                  style: textStyle,
                ),
                Text(
                  widget.info,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Oferta del Cliente',
                    style: textStyle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.monto.toString(),
                      style: textStyle.copyWith(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                            child: Icon(
                              Icons.arrow_circle_up,
                              size: 25,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.monto += 10;
                              });
                            }),
                        ElevatedButton(
                            child: Icon(
                              Icons.arrow_circle_down,
                              size: 25,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.monto -= 10;
                              });
                            })
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Aceptar',
                            style: textStyle.copyWith(
                                fontWeight: FontWeight.normal,
                                color: Colors.white))),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Rechazar',
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.normal, color: Colors.blue),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userInformacion(String datosUsuario, double monto1) {
    var nombreCliente = datosUsuario.split(" ");
    double monto = monto1;
    var textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return Container(
      color: Colors.blue.shade200,
      height: 120,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Información del cliente', style: textStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 35,
                child: FadeInImage(
                  placeholder: AssetImage('./assets/jar-loading.gif'),
                  image: NetworkImage(
                      'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'),
                ),
              ),
              Text(
                nombreCliente[0],
                style: textStyle.copyWith(fontSize: 30),
              )
            ],
          ),
        ],
      ),
    );
  }
}
