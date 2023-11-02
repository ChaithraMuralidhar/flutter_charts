import 'package:charts_graphs/data/models/chart.dart';
import 'package:charts_graphs/data/repositories/line_repo.dart';
import 'package:charts_graphs/presentation/line_charts/line_chart_demo.dart';
import 'package:charts_graphs/presentation/line_charts/line_chart_four.dart';
import 'package:charts_graphs/presentation/line_charts/line_chart_one.dart';
import 'package:charts_graphs/presentation/line_charts/line_chart_three.dart';
import 'package:charts_graphs/presentation/line_charts/line_chart_two.dart';
import 'package:flutter/material.dart';

final lineCharts = Chart(
  name: 'Line Charts',
  child: const LineChartOne(
    isShowingMainData: false,
  ),
  types: [
    Chart(
      name: 'Line Chart One',
      builder: () => const LineChartOne(
        isShowingMainData: false,
      ),
    ),
    Chart(
      name: 'Line Chart Two',
      builder: () => const LineChartTwo(),
    ),
    Chart(
      name: 'Line Chart Three',
      builder: () => LineChartThree(),
    ),
    Chart(
      name: 'Line Chart Four',
      builder: () => const LineChartFour(),
    ),
    Chart(
      name: 'Line Chart Five',
      builder: () => LineChartDemo(
        lineChartData: LineRepository().lineChartData,
        isShowSpots: true,
        lineColor: Colors.blue,
        lineAreaColor: Colors.blue,
        lineDotColor: Colors.blue,
        lineDotLabelColor: Colors.blue,
      ),
    ),
  ],
);
