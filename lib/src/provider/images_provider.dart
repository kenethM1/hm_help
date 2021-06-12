import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:hm_help/src/provider/ProviderValidator/ValidatorsItem.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImagesProvider extends ChangeNotifier {
  List<File> _list = [];
  List<String> _url = [];
  TaskSnapshot? taskSnapshot;
  String _porcentaje = '0';
  ValidatorItem? _titulo = new ValidatorItem(null, null);
  ValidatorItem? _descripcion = new ValidatorItem(null, null);
  ValidatorItem? _monto = new ValidatorItem(null, null);

  imagesProvider() {
    _list = [];
    _url = [];
  }

  List<File> get listaImagenes => _list;
  List<String> get linksDescarga => _url;
  ValidatorItem get titulo => _titulo!;
  ValidatorItem get descripcion => _descripcion!;
  ValidatorItem get monto => _monto!;
  String get porcentaje => _porcentaje;

  set listaImagenes(List<File> list) {
    _list = list;

    notifyListeners();
  }

  set changePorcentaje(String newvalue) {
    _porcentaje = newvalue;
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

  void guardar() async {
    final _storage = FirebaseStorage.instance;
    await FirebaseAuth.instance.signInAnonymously();

    int i = 1;
    _list.forEach((imagen) async {
      print('Subiendo imagen $i');
      final task = await _storage.ref('files/Propuesta_$i').putFile(imagen);
      final progress = task.bytesTransferred / task.totalBytes;
      changePorcentaje = progress.toStringAsFixed(2);
      i++;
      linksDescarga.add(await task.ref.getDownloadURL());
      listaImagenes = [];

      notifyListeners();
    });
  }

  void clearList() {
    _list.clear();
    notifyListeners();
  }
}
