import 'package:flutter/material.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/provider/images_provider.dart';
import 'package:hm_help/src/styles/Styles.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
                    'Correo electrónico',
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

            provider.changeProfileImg = await provider.getImage();
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
}
