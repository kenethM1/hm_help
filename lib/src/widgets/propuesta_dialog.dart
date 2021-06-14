import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Propuesta.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:hm_help/src/provider/listaContratista_provider.dart';

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
    return Center(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      height: 380,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          userInformacion(),
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
                    final propuestasProvider = new PropuestasProvider();
                    propuestasProvider.acceptPropuesta(widget.propuestaList);
                    Navigator.pop(context);
                  },
                  child: Text('Aceptar',
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white))),
              ElevatedButton(
                onPressed: () {
                  PropuestasProvider propuestasProvider =
                      new PropuestasProvider();
                  propuestasProvider
                      .removePropuesta(widget.propuestaList.id.toString());
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
    ));
  }

  Widget userInformacion() {
    var nombreCliente = widget.propuestaList.nombreUsuario!.split(" ");
    var textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue.shade200, borderRadius: BorderRadius.circular(20)),
      height: 120,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Información del cliente', style: textStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder<String?>(
                future: ContratistasProvider().contratistaImageURL(
                    widget.propuestaList.nombreContratista!),
                builder: (context, snapshot) {
                  return (snapshot.hasData)
                      ? Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: new BoxDecoration(
                            color: Colors.blue.shade300,
                            image: new DecorationImage(
                              image: new NetworkImage(snapshot.data!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(50.0)),
                            border: new Border.all(
                              color: Colors.blue.shade300,
                              width: 4.0,
                            ),
                          ),
                        )
                      : CircularProgressIndicator();
                },
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
