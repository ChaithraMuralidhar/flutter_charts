import 'scatter_chart_TouchedSpot.dart';
import 'scatter_noCorrelation_animations.dart';
import 'scatter_noCorrelation.dart';
import './scatterchart_data_passing.dart';

import 'Scatter_ChartBucketingAxis.dart';
import '../../data/models/chart.dart';
import 'scatter_chartSimple.dart';
import 'scatter_noCorrelation.dart';
import 'scatter_chartSimpleTwo.dart';
import 'scatter_Chart_Shapes.dart';
import 'scatter_ComparisonPoints.dart';
import 'scatterPlotChart.dart';
import 'package:d_chart/d_chart.dart';
import '../../data/models/scatter_chart_data.dart';

final scatterchart = Chart(
  // name: 'Scatter Chart',
  // builder: () => ScatterChartSimple(),
  name: 'Bucketing Axis Chart',
  builder: () => ScatterChartBucketingAxis(
    data: ScatterChartBucketingAxis.sampleData,
  ),
  types: [
    Chart(
      name: 'Shapes Chart',
      builder: () => ScatterChartShapes(
        data1: [
          DChartScatterData(
              domain: 6, measure: 23, size: 10, type: SymbolType.rect),
          DChartScatterData(
              domain: 2, measure: 12, size: 5, type: SymbolType.circle),
          DChartScatterData(
              domain: 3, measure: 19, size: 10, type: SymbolType.triangle)
        ],
        data2: [
          DChartScatterData(domain: 1, measure: 15, type: SymbolType.circle),
          DChartScatterData(
              domain: 3, measure: 25, size: 5, type: SymbolType.rect),
          DChartScatterData(domain: 5, measure: 7, type: SymbolType.circle),
        ],
      ),
    ),
    Chart(
      name: 'Bucketing Axis Chart',
      builder: () => ScatterChartBucketingAxis(
        data: ScatterChartBucketingAxis.sampleData,
      ),
    ),
    Chart(
      name: 'Simple Chart',
      builder: () => ScatterChartSimple(),
    ),
    Chart(
      name: 'Dot Chart',
      builder: () => ScatterChartSimpleTwo(
        data1: [
          DChartScatterData(domain: 1, measure: 23),
          DChartScatterData(domain: 2, measure: 12),
          DChartScatterData(domain: 3, measure: 19),
        ],
        data2: [
          DChartScatterData(domain: 1, measure: 15),
          DChartScatterData(domain: 3, measure: 25),
          DChartScatterData(domain: 5, measure: 7),
        ],
      ),
    ),
    Chart(
      name: 'Comparison Points Chart',
      builder: () => ScatterComparisonPoints(
        data1: [
          DChartScatterData(
              domain: 1, measure: 10, size: 10, type: SymbolType.rect),
          DChartScatterData(domain: 2, measure: 12, type: SymbolType.circle),
          DChartScatterData(domain: 3, measure: 19, startPlot: DPlot(2, 12)),
        ],
        data2: [
          DChartScatterData(
              domain: 1,
              measure: 15,
              type: SymbolType.triangle,
              size: 10,
              startPlot: DPlot(3, 25)),
          DChartScatterData(domain: 3, measure: 25),
          DChartScatterData(domain: 5, measure: 15, startPlot: DPlot(5, 0)),
        ],
      ),
    ),
    Chart(
      name: 'No Correlation Chart',
      builder: () => const ScatterNoCorrelation(),
    ),

    // Chart(
    //   name: 'Scatter Touched Spot (working...)',
    //   builder: () => const ScatterTouchedSpot(),
    // ),

    Chart(
      name: 'Plot Chart (with axis Title)',
      builder: () => ScatterPlotChart(
        data: [
          ScatterChartDataItem(x: 0, y: 5, radius: 3.0),
          ScatterChartDataItem(x: 10, y: 25, radius: 5.0),
          ScatterChartDataItem(x: 12, y: 75, radius: 4.0),
          ScatterChartDataItem(x: 13, y: 225, radius: 5.0),
          ScatterChartDataItem(x: 16, y: 50, radius: 4.0),
          ScatterChartDataItem(x: 24, y: 75, radius: 3.0),
          ScatterChartDataItem(x: 25, y: 100, radius: 3.0),
          ScatterChartDataItem(x: 34, y: 150, radius: 5.0),
          ScatterChartDataItem(x: 37, y: 10, radius: 4.5),
          ScatterChartDataItem(x: 45, y: 300, radius: 8.0),
          ScatterChartDataItem(x: 52, y: 15, radius: 4.0),
          ScatterChartDataItem(x: 56, y: 200, radius: 7.0),
        ],
        scatterChartbehaviors: ScatterChartbehaviors(
            chartTopTitle: "Year waise Sales",
            yAxisTitle: "Sales",
            xAxisTitle: "Years"),
      ),
    ),

    Chart(
      name: 'Scatter Chart (With Touched Spot)',
      builder: () => ScatterNoCorrelationAnimation(
        scatterChartData: scatterChartData,
      ),
    ),
  ],
);
