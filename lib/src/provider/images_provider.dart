import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Propuesta.dart';
import 'package:hm_help/src/models/Usuario.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:hm_help/src/provider/PropuestasProvider.dart';
import 'package:hm_help/src/provider/ProviderValidator/ValidatorsItem.dart';

class ImagesProvider extends ChangeNotifier {
  String _imageProfile = new PreferenciasUsuario().imgURL;
  List<File> _list = [];
  List<String> _url = [];
  TaskSnapshot? taskSnapshot;
  ValidatorItem? _titulo = new ValidatorItem(null, null);
  ValidatorItem? _descripcion = new ValidatorItem(null, null);
  ValidatorItem? _monto = new ValidatorItem(null, null);
  String _rubro = 'fdc8358d-b30d-48bc-ac8b-f230019e6d1f';

  imagesProvider() {}

  List<File> get listaImagenes => _list;
  List<String> get linksDescarga => _url;
  ValidatorItem get titulo => _titulo!;
  ValidatorItem get descripcion => _descripcion!;
  ValidatorItem get monto => _monto!;
  String get profileImg => _imageProfile;
  String get rubro => _rubro;

  set listaImagenes(List<File> list) {
    _list = list;

    notifyListeners();
  }

  set changeRubro(String newRubro) {
    _rubro = newRubro;
    notifyListeners();
  }

  void changeTitulo(String value) {
    if (value.length >= 3) {
      _titulo = ValidatorItem(value, null);
    } else {
      _titulo = ValidatorItem(null, "Escribe tantito más!!");
    }
    notifyListeners();
  }

  void changeDescripcion(String value) {
    if (value.length >= 3) {
      _descripcion = ValidatorItem(value, null);
    } else {
      _descripcion = ValidatorItem(null, "Escribe tantito más!!");
    }
    notifyListeners();
  }

  void changeMonto(String value) {
    RegExp regExp = RegExp(r'^-?[0-9]+$');

    if (regExp.hasMatch(value)) {
      _monto = ValidatorItem(value, null);
    } else {
      _monto = ValidatorItem(null, "Monto no válido");
    }
    notifyListeners();
  }

  void guardar(Usuario contratista) async {
    PropuestasProvider provider = PropuestasProvider();
    final _storage = FirebaseStorage.instance;
    await FirebaseAuth.instance.signInAnonymously();

    String? monto = _monto!.value;

    int iterador = 0;
    _list.forEach((imagen) async {
      print('Subiendo imagen $iterador');
      final task = await _storage
          .ref('files/Propuesta_$iterador-${_titulo!.value}')
          .putFile(imagen);
      iterador++;

      linksDescarga.add(await task.ref.getDownloadURL());

      listaImagenes = [];
    });

    final propuesta = new Propuesta(
      contratistaID: contratista.id,
      rubroID: rubro,
      nombre: _titulo!.value,
      descripcion: _descripcion!.value,
      monto: double.parse(monto!),
    );

    bool isOk = await provider.uploadPropuesta(propuesta, _url);
    notifyListeners();
  }

  void clearList() {
    _list.clear();
    notifyListeners();
  }

  set changeProfileImg(String imgURL) {
    _imageProfile = imgURL;
    notifyListeners();
  }
}
