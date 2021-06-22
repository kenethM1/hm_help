import 'package:flutter_test/flutter_test.dart';
import 'package:hm_help/src/provider/listaContratista_provider.dart';
import 'package:http/http.dart' as http;

main() {
  test('La conexion es correcta', () {
    //Arrange
    http.Response response = http.Response('json', 200);

    //Act
    bool? isConnectionOk = ContratistasProvider().verifyConnection(response);

    //Assert
    expect(isConnectionOk, true);
  });
}
