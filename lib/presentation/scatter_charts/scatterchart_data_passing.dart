import 'package:charts_graphs/data/models/scatter_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';

final scatterChartData = ScattersChartData(
  scatterSpots: [
    ScatterSpot(9, 4, radius: 14),
    ScatterSpot(4, 4, radius: 15),
    ScatterSpot(7, 5, radius: 15),
    ScatterSpot(4, 8, radius: 16),
    ScatterSpot(1, 3, radius: 10),
    ScatterSpot(9, 2, radius: 12),
    ScatterSpot(5, 2, radius: 12),
    ScatterSpot(2, 7, radius: 14),
  ],
  xAxisStart: 0,
  xAxisEnd: 20,
  yAxisStart: 0,
  yAxisEnd: 10,
);
