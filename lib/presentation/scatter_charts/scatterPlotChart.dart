import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../../data/models/scatter_chart_data.dart';

class ScatterPlotChart extends StatelessWidget {
  final List<ScatterChartDataItem> data;

  final ScatterChartbehaviors scatterChartbehaviors;

  const ScatterPlotChart({
    super.key,
    required this.data,
    required this.scatterChartbehaviors,
  });

  @override
  Widget build(BuildContext context) {
    final maxMeasure = 300;
    final List<charts.Series<dynamic, int>> _data = [
      charts.Series<ScatterChartDataItem, int>(
        id: 'Sales',
        // colorFn: (ScatterChartDataItem y, _) {
        //   final bucket = y.y / maxMeasure;

        //   if (bucket < 1 / 3) {
        //     return charts.MaterialPalette.blue.shadeDefault;
        //   } else if (bucket < 2 / 3) {
        //     return charts.MaterialPalette.red.shadeDefault;
        //   } else {
        //     return charts.MaterialPalette.green.shadeDefault;
        //   }
        // },

        seriesColor: charts.MaterialPalette.red.shadeDefault,
        domainFn: (ScatterChartDataItem y, _) => y.x,
        measureFn: (ScatterChartDataItem y, _) => y.y,
        radiusPxFn: (ScatterChartDataItem y, _) => y.radius,
        data: data,
      ),
    ];

    return charts.ScatterPlotChart(
      animationDuration: Duration(seconds: 2),
      List.from(_data),
      animate: scatterChartbehaviors.animate,
      behaviors: [
        charts.ChartTitle(scatterChartbehaviors.chartTopTitle,
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            innerPadding: 25),
        charts.ChartTitle(
          scatterChartbehaviors.yAxisTitle!,
          behaviorPosition: charts.BehaviorPosition.start,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
        ),
        charts.ChartTitle(
          scatterChartbehaviors.xAxisTitle!,
          behaviorPosition: charts.BehaviorPosition.bottom,
          titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
        ),
      ],
    );
  }
}
