import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Propuesta.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';

class PropuestaDialog extends StatefulWidget {
  PropuestaDialog({
    Key? key,
    required this.propuestaList,
    required this.recargar,
  }) : super(key: key);

  Propuesta propuestaList;
  Function recargar;

  @override
  _PropuestaState createState() => _PropuestaState();
}

class _PropuestaState extends State<PropuestaDialog> {
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18);
    return SingleChildScrollView(
      child: Container(
        child: AlertDialog(
          contentPadding: EdgeInsets.all(0),
          insetPadding: EdgeInsets.only(bottom: 150, top: 150),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          elevation: 10,
          content: Container(
            height: 380,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                userInformacion(widget.propuestaList.nombreUsuario.toString(),
                    widget.propuestaList.monto!),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Detalles',
                  style: textStyle,
                ),
                Text(
                  widget.propuestaList.descripcion!,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'L${widget.propuestaList.monto!.toInt().toString()}.00',
                      style: textStyle.copyWith(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
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
                      onPressed: () {
                        PropuestasProvider propuestasProvider =
                            new PropuestasProvider();
                        propuestasProvider.removePropuesta(
                            widget.propuestaList.id.toString());
                        Navigator.pop(context);
                        widget.recargar(widget.propuestaList.id);
                      },
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
