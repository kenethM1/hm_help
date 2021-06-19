import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Propuesta.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:hm_help/src/provider/listaContratista_provider.dart';
import 'package:hm_help/src/styles/Styles.dart';

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
      height: 550,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          userInformacion(),
          SizedBox(
            height: 10,
          ),
          Text(
            'Detalles',
            style: textStyle,
          ),
          carrousel(widget.propuestaList),
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
          (widget.propuestaList.status == 'Aceptada')
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          final propuestasProvider = new PropuestasProvider();
                          bool isSubmited = false;

                          Center(
                            child: CircularProgressIndicator(),
                          );

                          isSubmited = await propuestasProvider
                              .acceptPropuesta(widget.propuestaList);

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
                )
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Aceptada',
                        style: new Styles().estilo.copyWith(color: Colors.blue),
                      ),
                      Icon(Icons.check_circle, color: Colors.blue)
                    ],
                  ),
                ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }

  Widget userInformacion() {
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FutureBuilder<String?>(
                future: ContratistasProvider()
                    .userImageURL(widget.propuestaList.usuarioID),
                builder: (context, snapshot) {
                  return (snapshot.hasData)
                      ? Container(
                          width: 70,
                          height: 70.0,
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
              SizedBox(
                width: 50,
              ),
              Text(
                widget.propuestaList.nombreUsuario!.split(' ')[0],
                style: textStyle.copyWith(fontSize: 30),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget carrousel(Propuesta propuestaList) {
    return (propuestaList.imagenes!.length != 0)
        ? CarouselSlider.builder(
            itemCount: propuestaList.imagenes!.length,
            itemBuilder: (context, int index, index2) =>
                Image.network(propuestaList.imagenes![index].url.toString()),
            options: CarouselOptions(
                autoPlay: true, autoPlayCurve: Curves.easeInOut),
          )
        : Container();
  }
}
