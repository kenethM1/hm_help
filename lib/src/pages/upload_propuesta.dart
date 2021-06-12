import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/provider/images_provider.dart';
import 'package:hm_help/src/styles/Styles.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class UploadPropuesta extends StatefulWidget {
  const UploadPropuesta({
    Key? key,
  }) : super(key: key);

  @override
  _UploadPropuestaState createState() => _UploadPropuestaState();
}

class _UploadPropuestaState extends State<UploadPropuesta> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImagesProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: size.width * 0.85,
          height: size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Propuesta',
                style: new Styles().estilo.copyWith(fontSize: 20),
              ),
              buildTituloField(provider),
              buildDescripcionField(provider),
              buildMontoField(provider),
              Consumer<ImagesProvider>(
                builder: (context, imagesList, child) {
                  return (imagesList.listaImagenes.isNotEmpty)
                      ? CarouselSlider.builder(
                          itemCount: imagesList.listaImagenes.length,
                          itemBuilder: (context, int index, index2) =>
                              Image.file(
                                  imagesList.listaImagenes[index].absolute),
                          options: CarouselOptions(
                              autoPlay: true, autoPlayCurve: Curves.easeInOut),
                        )
                      : Container(
                          height: 250,
                          width: 250,
                          child: Image(
                            image: AssetImage('assets/upload.png'),
                            fit: BoxFit.fill,
                          ),
                        );
                },
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  onPressed: getImage,
                  child: Text('Cargar Imagen')),
              (provider.listaImagenes.isNotEmpty)
                  ? buildOpcionesSiFormEstaCompleto(provider)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildOpcionesSiFormEstaCompleto(ImagesProvider provider) {
    return Column(
      children: [
        ElevatedButton(
            child: Text('Eliminar Imagenes'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () => provider.clearList()),
        ElevatedButton(
            child: Text('Subir Propuesta'),
            style: ElevatedButton.styleFrom(primary: Colors.blue),
            onPressed: () {
              provider.guardar();
              Navigator.pop(context);
            }),
      ],
    );
  }

  Container buildMontoField(ImagesProvider provider) {
    return Container(
      height: 90,
      child: Drawer(
        elevation: 0,
        child: TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 15),
          maxLines: 5,
          minLines: 1,
          textAlign: TextAlign.center,
          onChanged: (value) => provider.changeMonto(value),
          decoration: InputDecoration(
              focusColor: Colors.blue,
              errorText: provider.monto.error,
              fillColor: Colors.grey.shade300,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Monto a pagar por tu propuesta.',
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Container buildDescripcionField(ImagesProvider provider) {
    return Container(
      height: 100,
      child: Drawer(
        elevation: 0,
        child: TextField(
          maxLines: 10,
          minLines: 1,
          textAlign: TextAlign.center,
          onChanged: (value) => provider.changeDescripcion(value),
          decoration: InputDecoration(
              focusColor: Colors.blue,
              errorText: provider.descripcion.error,
              fillColor: Colors.grey.shade300,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Descripción de tú propuesta',
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Container buildTituloField(ImagesProvider provider) {
    return Container(
      height: 70,
      child: Drawer(
        elevation: 0,
        child: TextField(
          textAlign: TextAlign.center,
          onChanged: (value) => provider.changeTitulo(value),
          maxLength: 25,
          decoration: InputDecoration(
              focusColor: Colors.blue,
              fillColor: Colors.grey.shade300,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Titulo de tu Propuesta',
              hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Future getImage() async {
    List<File> resultList = [];
    try {
      FilePickerResult result = (await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      ))!;
      final imagesList = Provider.of<ImagesProvider>(context, listen: false);
      resultList = result.paths.map((path) => File(path!)).toList();
      imagesList.listaImagenes = resultList;
    } catch (e) {
      print(e.toString());
    }
  }
}
