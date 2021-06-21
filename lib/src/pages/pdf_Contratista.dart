import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hm_help/src/pages/pdf_Widget.dart';
import 'package:path/path.dart';
import '../provider/firebase_Api.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Hoja de Vida';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        color: Colors.black,
        theme: ThemeData(primaryColor: Colors.blue),
        home: PdfContratistaPage(),
      );
}

class PdfContratistaPage extends StatefulWidget {
  @override
  _PdfContratistaPageState createState() => _PdfContratistaPageState();
}

class _PdfContratistaPageState extends State<PdfContratistaPage> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No seleccionado';

    return Scaffold(
      appBar: AppBar(
        title: Text('Hoja de vida'),
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
      ),
      body: Container(
          padding: EdgeInsets.all(25),
          color: Colors.blue.shade200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: SizedBox(
                    height: 35,
                    width: 350,
                    child: ButtonWidget(
                      text: 'Seleccionar Archivo PDF',
                      icon: Icons.picture_as_pdf_rounded,
                      onClicked: selectFile,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  fileName,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 35,
                    width: 350,
                    child: ButtonWidget(
                      text: 'Cargar Documento',
                      icon: Icons.cloud_upload_outlined,
                      onClicked: uploadFile,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                task != null ? buildUploadStatus(task!) : Container(),
                SizedBox(height: 1),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Regresar al registro",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(0);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
