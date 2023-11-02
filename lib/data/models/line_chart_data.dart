import 'package:fl_chart/fl_chart.dart';

class LineChartsData {
  final List<LineChartDataItem> labels;
  final List<FlSpot> spots;
  final double maxX;
  final double maxY;
  final String xLabel;
  final String yLabel;

  LineChartsData(
      {required this.labels,
      required this.spots,
      required this.maxX,
      required this.maxY,
      required this.xLabel,
      required this.yLabel});
}

class LineChartDataItem {
  final String xLabel;
  final String yLabel;

  LineChartDataItem({required this.xLabel, required this.yLabel});
}
