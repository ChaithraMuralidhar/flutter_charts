import 'package:charts_flutter_new/flutter.dart' as charts;
import '/data/models/scatter_chart_data.dart';
import 'package:flutter/material.dart';

class ScatterChartBucketingAxis extends StatelessWidget {
  final List<charts.Series<dynamic, int>> data;
  final bool animate;

  const ScatterChartBucketingAxis({
    super.key,
    required this.data,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return charts.ScatterPlotChart(List.from(data),
        primaryMeasureAxis: charts.BucketingAxisSpec(
            threshold: 0.1,
            tickProviderSpec: const charts.BucketingNumericTickProviderSpec(
                desiredTickCount: 3)),
        behaviors: [
          charts.SeriesLegend(position: charts.BehaviorPosition.end),
        ],
        animate: animate);
  }

  static List<charts.Series<LinearSales, int>> get sampleData {
    final myFakeDesktopData = [
      LinearSales(52, 0.75, 14.0),
    ];

    final myFakeTabletData = [
      LinearSales(45, 0.3, 18.0),
    ];

    final myFakeMobileData = [
      LinearSales(56, 0.8, 17.0),
    ];

    final myFakeChromebookData = [
      LinearSales(25, 0.6, 13.0),
    ];

    final myFakeHomeData = [
      LinearSales(34, 0.5, 15.0),
    ];

    final myFakeOtherData = [
      LinearSales(10, 0.25, 15.0),
      LinearSales(12, 0.075, 14.0),
      LinearSales(13, 0.225, 15.0),
      LinearSales(16, 0.03, 14.0),
      LinearSales(24, 0.04, 13.0),
      LinearSales(37, 0.1, 14.5),
    ];

    return [
      charts.Series<LinearSales, int>(
          id: 'Desktop',
          colorFn: (LinearSales sales, _) =>
              charts.MaterialPalette.blue.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: myFakeDesktopData),
      charts.Series<LinearSales, int>(
          id: 'Tablet',
          colorFn: (LinearSales sales, _) =>
              charts.MaterialPalette.red.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: myFakeTabletData),
      charts.Series<LinearSales, int>(
          id: 'Mobile',
          colorFn: (LinearSales sales, _) =>
              charts.MaterialPalette.green.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: myFakeMobileData),
      charts.Series<LinearSales, int>(
          id: 'Chromebook',
          colorFn: (LinearSales sales, _) =>
              charts.MaterialPalette.purple.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: myFakeChromebookData),
      charts.Series<LinearSales, int>(
          id: 'Home',
          colorFn: (LinearSales sales, _) =>
              charts.MaterialPalette.indigo.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: myFakeHomeData),
      charts.Series<LinearSales, int>(
          id: 'Other',
          colorFn: (LinearSales sales, _) =>
              charts.MaterialPalette.gray.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: myFakeOtherData),
    ];
  }
}
