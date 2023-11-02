import 'package:charts_graphs/data/models/chart.dart';
import 'package:charts_graphs/data/repositories/line_repo.dart';
import 'package:charts_graphs/presentation/line_charts/line_chart_one.dart';
import 'package:charts_graphs/presentation/pie_chart/doughnut.dart';
import 'package:charts_graphs/presentation/pie_chart/pie_chart.dart';
import 'package:charts_graphs/presentation/pie_chart/radialbar.dart';
import 'package:flutter/material.dart';

final pieCharts = Chart(
  name: 'Pie Charts',
  child: const PieChart(
    isShowingMainData: true,
  ),
  types: [
    Chart(
      name: 'Pie Chart',
      builder: () => const PieChart(
        isShowingMainData: true,
      ),
    ),
     Chart(
      name: 'Doughnut Chart',
      builder: () => const DoughnutChart(
        isShowingMainData: true,
      ),
    ),
     Chart(
      name: 'RadialBar Chart',
      builder: () => const RadialBarChart(
        isShowingMainData: true,
      ),
    ),
  ],
);
