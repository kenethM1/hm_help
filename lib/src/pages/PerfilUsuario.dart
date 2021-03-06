import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/provider/images_provider.dart';
import 'package:hm_help/src/provider/usuario_provider.dart';
import 'package:hm_help/src/styles/Styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<PerfilUsuario> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final preferenciaUsuario = PreferenciasUsuario();
    return Scaffold(
        body: SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            ImageAndCameraButton(
                size: size, preferenciaUsuario: preferenciaUsuario),
            ElevatedButton(
              child: Text("Foto de Perfil"),
              onPressed: getImage,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              preferenciaUsuario.nombre.toUpperCase(),
              style: new Styles().estilo.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width - 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Correo electr??nico',
                    style: new Styles()
                        .estilo
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(preferenciaUsuario.correoUsuario,
                      style: new Styles().estilo.copyWith(
                          color: Colors.grey.shade500,
                          fontSize: 15,
                          fontWeight: FontWeight.normal))
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _fotoCamara() {
    final ImagePicker picture = ImagePicker();
    picture.getImage(source: ImageSource.camera);
  }

  void _fotoGaleria() {
    final ImagePicker picture = ImagePicker();
    picture.getImage(source: ImageSource.gallery);
  }

  Future<void> _opciondeFoto() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Tomar Foto"),
                    onTap: () {
                      _fotoCamara();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Seleccionar Foto"),
                    onTap: () {},
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<String> getImage() async {
    List<File> image;
    String? imgLink;
    final preferenciasUsuarios = new PreferenciasUsuario();
    final usuarioProvider = UsuarioProvider();
    try {
      FilePickerResult result = (await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      ))!;
      image = result.paths.map((path) => File(path!)).toList();
      imgLink = await guardarImg(image, preferenciasUsuarios.nombre);
      usuarioProvider.updateUsuario(Usuario(imageURL: imgLink));
    } catch (e) {}
    return imgLink ?? preferenciasUsuarios.imgURL;
  }

  Future<String> guardarImg(List<File> img, String userName) async {
    final _storage = FirebaseStorage.instance;
    await FirebaseAuth.instance.signInAnonymously();

    final task =
        await _storage.ref('files/ProfilePic_$userName').putFile(img[0]);
    final linkDescarga = await task.ref.getDownloadURL();

    return linkDescarga;
  }
}

class ImageAndCameraButton extends StatefulWidget {
  const ImageAndCameraButton({
    Key? key,
    required this.size,
    required this.preferenciaUsuario,
  }) : super(key: key);

  final Size size;
  final PreferenciasUsuario preferenciaUsuario;

  @override
  _ImageAndCameraButtonState createState() => _ImageAndCameraButtonState();
}

class _ImageAndCameraButtonState extends State<ImageAndCameraButton> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImagesProvider>(context, listen: false);
    return Stack(children: [
      Container(
        height: 400,
        color: Colors.blue,
      ),
      Padding(
        padding: EdgeInsets.only(top: 250, left: widget.size.width / 5),
        child: Consumer<ImagesProvider>(builder: (context, value, child) {
          return (value.profileImg.isNotEmpty)
              ? Container(
                  width: 250.0,
                  height: 250.0,
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    image: new DecorationImage(
                      image: new NetworkImage(provider.profileImg),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(150.0)),
                    border: new Border.all(
                      color: Colors.blue.shade300,
                      width: 1.0,
                    ),
                  ),
                )
              : CircularProgressIndicator();
        }),
      ),
      Positioned(
        top: widget.size.height * 0.55,
        left: widget.size.width * 0.65,
        child: InkWell(
          focusColor: Colors.grey,
          hoverColor: Colors.grey,
          onTap: () async {
            final provider =
                Provider.of<ImagesProvider>(context, listen: false);

            provider.changeProfileImg = await getImage();
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              height: 50,
              width: 50,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 35,
              )),
        ),
      )
    ]);
  }

  Future<String> getImage() async {
    List<File> image;
    String? imgLink;
    final preferenciasUsuarios = new PreferenciasUsuario();
    final usuarioProvider = UsuarioProvider();
    try {
      FilePickerResult result = (await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      ))!;
      image = result.paths.map((path) => File(path!)).toList();
      imgLink = await guardarImg(image, preferenciasUsuarios.nombre);
      usuarioProvider.updateUsuario(Usuario(imageURL: imgLink));
    } catch (e) {}
    return imgLink ?? preferenciasUsuarios.imgURL;
  }

  Future<String> guardarImg(List<File> img, String userName) async {
    final _storage = FirebaseStorage.instance;
    await FirebaseAuth.instance.signInAnonymously();

    final task =
        await _storage.ref('files/ProfilePic_$userName').putFile(img[0]);
    final linkDescarga = await task.ref.getDownloadURL();

    return linkDescarga;
  }
}
