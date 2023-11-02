import 'dart:ui';

import 'package:charts_graphs/presentation/area-graph_charts/area_graph_all.dart';
import 'package:charts_graphs/presentation/charts_page.dart';
import 'package:charts_graphs/presentation/line_charts/line_all_charts.dart';
import 'package:charts_graphs/presentation/pie_chart/pie_chart_list.dart';
import 'package:charts_graphs/presentation/scatter_charts/scatterChart_data.dart';
import 'package:charts_graphs/utils/theme_changer.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'presentation/bar_charts/barchart_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    final charts = [barcharts, lineCharts, scatterchart, areagraphs,pieCharts];

    return MaterialApp(
      title: 'Charts and Graphs',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme,
      home: Stack(children: [
        const RiveAnimation.asset("shapes.riv", fit: BoxFit.cover),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          ),
        ),
        ChartsPage(charts: charts)
      ]),
    );
  }
}
