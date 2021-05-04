import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradiente = [Colors.white, Colors.grey.shade200];
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.blue.shade200,
        height: 200,
        width: 350,
        child: LineChart(
            LineChartData(minX: 0, maxX: 11, maxY: 6, minY: 0, lineBarsData: [
          LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(1, 4),
                FlSpot(2, 5),
                FlSpot(3, 2),
                FlSpot(4, 3),
                FlSpot(5, 4),
                FlSpot(6, 5),
                FlSpot(7, 2),
                FlSpot(8, 3),
                FlSpot(9, 4),
                FlSpot(10, 5),
                FlSpot(11, 2),
              ],
              isCurved: true,
              dotData: FlDotData(show: false),
              barWidth: 6,
              colors: gradiente,
              belowBarData: BarAreaData(
                  colors:
                      gradiente.map((color) => color.withOpacity(0.4)).toList(),
                  show: true))
        ])),
      ),
    );
  }
}
