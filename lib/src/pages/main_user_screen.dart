import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hm_help/src/widgets/line_chart.dart';

class MainUserScreen extends StatelessWidget {
  const MainUserScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tamano = MediaQuery.of(context).size;
    TextStyle estilo = TextStyle(
        color: Colors.blue.shade200, fontSize: 24, fontWeight: FontWeight.bold);
    LineChartData data = LineChartData();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ChartPage(estilo: estilo),
            Container(
                height: tamano.height * 0.4678,
                width: tamano.width,
                color: Colors.blue.shade200)
          ],
        ),
      ),
    );
  }
}

class ChartPage extends StatelessWidget {
  const ChartPage({
    Key key,
    @required this.estilo,
  }) : super(key: key);

  final TextStyle estilo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Resumen Anual',
          style: estilo,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Ganancias',
              style: estilo,
            ),
            Text(
              'L. 9500',
              style: estilo,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ChartWidget(),
        Container(
            //color: Colors.red,
            alignment: Alignment.center,
            height: 70,
            width: 200,
            child: Text(
              'Ofertas',
              style: estilo,
            ))
      ],
    );
  }
}
