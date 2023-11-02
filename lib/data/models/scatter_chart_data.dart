import 'package:fl_chart/fl_chart.dart';

class ScattersChartData {
  final List<ScatterSpot> scatterSpots;
  final double xAxisStart;
  final double xAxisEnd;
  final double yAxisStart;
  final double yAxisEnd;

  ScattersChartData({
    required this.scatterSpots,
    required this.xAxisStart,
    required this.xAxisEnd,
    required this.yAxisStart,
    required this.yAxisEnd,
  });
}

class ScatterChartDataItem {
  final int x;
  final int y;
  final double radius;

  ScatterChartDataItem({
    required this.x,
    required this.y,
    required this.radius,
  });
}

class ScatterChartbehaviors {
  final bool animate;
  final String chartTopTitle;
  final String? yAxisTitle;
  final String? xAxisTitle;

  ScatterChartbehaviors({
    this.animate = true,
    required this.chartTopTitle,
    this.yAxisTitle,
    this.xAxisTitle,
  });
}

class LinearSales {
  final int year;
  final double revenueShare;
  final double radius;

  LinearSales(this.year, this.revenueShare, this.radius);
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
