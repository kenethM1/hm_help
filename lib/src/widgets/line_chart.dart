import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hm_help/src/models/Propuesta.dart';
import 'package:hm_help/src/preferencias_usuario/preferencias_usuario.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<List<MesAgrupado>> snapshot;

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    final List<Color> gradiente = [Colors.white, Colors.grey.shade200];
    return Container(
      height: 200,
      width: 370,
      margin: EdgeInsets.only(bottom: 10, right: 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.lightBlue,
                  blurRadius: 20,
                  spreadRadius: 1,
                  offset: Offset(0, 3))
            ]),
        child: LineChart(LineChartData(
            lineTouchData: LineTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: buildButtonTitle(),
              leftTitles: builLeftTitle(context),
            ),
            minX: 0,
            maxX: 11,
            maxY: prefs.gananciaMaxima!.toDouble() + 1000,
            minY: 0,
            borderData: FlBorderData(
                show: false,
                border: Border(left: BorderSide.none, bottom: BorderSide.none)),
            gridData: FlGridData(drawVerticalLine: false, show: false),
            lineBarsData: [
              LineChartBarData(
                  spots: _generarPuntos(snapshot),
                  isCurved: true,
                  barWidth: 5,
                  colors: gradiente,
                  dotData: FlDotData(
                    show: false,
                  ),
                  belowBarData: BarAreaData(
                      colors: gradiente
                          .map((color) => color.withOpacity(0.4))
                          .toList(),
                      show: true))
            ])),
      ),
    );
  }

  SideTitles buildButtonTitle() {
    return SideTitles(
      reservedSize: 40,
      interval: 2,
      margin: 5,
      getTextStyles: (value) {
        return const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        );
      },
      getTitles: (value) {
        switch (value.toInt()) {
          case 0:
            return 'ENE';
          case 1:
            return 'FEB';
          case 2:
            return 'MAR';
          case 3:
            return 'ABR';
          case 4:
            return 'MAY';
          case 5:
            return 'JUN';
          case 6:
            return 'JUL';
          case 7:
            return 'AGO';
          case 8:
            return 'SEP';
          case 9:
            return 'OCT';
          case 10:
            return 'NOV';
          case 11:
            return 'DIC';
        }
        return '';
      },
      showTitles: true,
    );
  }

  List<FlSpot> _generarPuntos(AsyncSnapshot<List<MesAgrupado>> snapshot) {
    final List<FlSpot> listofPoints = [];
    final FlSpot flSpot;
    double mes;
    int contadorMes = 0;

    for (var i = 0; i < 12; i++) {
      if (i == int.parse(snapshot.data![contadorMes].mes!)) {
        listofPoints.add(FlSpot(double.parse(snapshot.data![contadorMes].mes!),
            snapshot.data![contadorMes].suma!));
      } else {
        listofPoints.add(FlSpot(i.toDouble(), 0));
      }
    }

    return listofPoints;
  }

  SideTitles builLeftTitle(BuildContext context) {
    return SideTitles(
      reservedSize: 65,
      interval: 2,
      margin: 10,
      getTextStyles: (value) {
        return const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        );
      },
      getTitles: (value) => returnTitle(value, context),
      showTitles: true,
    );
  }

  String returnTitle(double value, BuildContext context) {
    final preferencias = PreferenciasUsuario();
    int maximo = preferencias.gananciaMaxima!;
    List<double> intervalo = retornarIntervalo(maximo);

    return (intervalo.contains(value)) ? 'L${value.toInt().toString()}.00' : '';
  }

  List<double> retornarIntervalo(int maximo) {
    double intervalo = maximo / 10;
    List<double> listaIntervalos = [];
    listaIntervalos.add(0);
    for (var i = intervalo; i <= maximo;) {
      i += intervalo;
      listaIntervalos.add(i);
    }
    return listaIntervalos;
  }
}
