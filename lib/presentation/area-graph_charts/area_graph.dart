import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AreaGraph extends StatefulWidget {
  const AreaGraph({super.key});

  @override
  State<AreaGraph> createState() => _AreaGraphState();
}

class _AreaGraphState extends State<AreaGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(1),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    )),
                lineBarsData: [
                  LineChartBarData(
                      spots: [
                        FlSpot(2, 3.5),
                        FlSpot(2.5, 4.5),
                        FlSpot(3, 5),
                        FlSpot(4, 7),
                        FlSpot(5, 6),
                        FlSpot(6, 9),
                        FlSpot(7, 11),
                        FlSpot(8, 10),
                      ],
                      isCurved: false,
                      color: Colors.blue,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                          show: true, color: Colors.blue.withOpacity(0.2)))
                ],
                minY: 0,
                titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                ))),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
