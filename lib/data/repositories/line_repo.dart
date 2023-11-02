import 'package:charts_graphs/data/data_provider/line_json.dart';
import 'package:charts_graphs/data/models/line_chart_data.dart';
import 'package:charts_graphs/data/models/line_data.dart';
import 'package:fl_chart/fl_chart.dart';

class LineRepository {
  LineData lData = LineData.fromJson(lineJsonData);

  LineRepository() {
    List<LineChartDataItem> graphLabels = lData.labels
        .map((e) => LineChartDataItem(xLabel: e.xLabel, yLabel: e.yLabel))
        .toList();

    List<FlSpot> graphPoints =
        lData.points.map((e) => FlSpot(e.xPoint, e.yPoint)).toList();

    lineChartData = LineChartsData(
        labels: graphLabels,
        spots: graphPoints,
        maxX: lData.maxX,
        maxY: lData.maxY,
        xLabel: lData.xLabel,
        yLabel: lData.yLabel);
  }
  late LineChartsData lineChartData;
}
