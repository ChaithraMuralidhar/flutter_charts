import 'package:charts_graphs/presentation/area-graph_charts/area_graph.dart';
import 'package:flutter/material.dart';
import '../../data/models/chart.dart';
import 'package:charts_graphs/presentation/area-graph_charts/area_graph_two.dart';
import 'package:charts_graphs/presentation/area-graph_charts/area_graph_gradient.dart';
import 'package:charts_graphs/presentation/area-graph_charts/area_graph_line.dart';
import 'package:charts_graphs/presentation/area-graph_charts/area_graph_overlapping.dart';
import 'package:charts_graphs/presentation/area-graph_charts/area_graph_legend.dart';

final areagraphs =
    Chart(name: 'Area Chart', builder: () => AreaGraph(), types: [
  Chart(name: "Area Graph", builder: () => AreaGraph()),
  Chart(name: "Area Graph Two", builder: () => AreaGraphTwo()),
  Chart(
      name: "Area Graph Gradient",
      builder: () => AreaGraphGradient(
            dataSeries: [
              [1, 3, 4, 5, 6, 2, 1],
              [3.5, 4, 5.5, 6.5, 3.4, 2.5, 1.0],
              [2, 2.5, 4.5, 5.5, 6.5, 4.5, 3.5],
            ],
            lineColors: [Colors.blue, Colors.blueGrey, Colors.green],
            fillColors: [Colors.blue, Colors.blueGrey, Colors.green],
            labels: [
              Legend(label: 'Q1', color: Colors.blue),
              Legend(label: 'Q2', color: Colors.blueGrey),
              Legend(label: 'Q3', color: Colors.green),
            ],
            gradientPair: [
              [Colors.blue, Colors.blueAccent],
              [Colors.blueGrey, Colors.blue],
              [Colors.green, Colors.greenAccent]
            ],
             graphTitle: 'Quarterly Expense Data',
            xAxisTitle: "Quarter",
            yAxisTitle: "Expense",
          )),
  Chart(
      name: "Area Graph Line",
      builder: () => AreaGraphLine(
            dataSeries: [
              [1, 3, 4, 5, 6, 2, 1],
              [3.5, 4, 5.5, 6.5, 3.4, 2.5, 1.0],
              [2, 2.5, 4.5, 5.5, 6.5, 4.5, 3.5],
            ],
            lineColors: [Colors.blue, Colors.blueGrey, Colors.green],
            fillColors: [Colors.blue, Colors.blueGrey, Colors.green],
            labels: [
              Legend(label: 'Q1', color: Colors.blue),
              Legend(label: 'Q2', color: Colors.blueGrey),
              Legend(label: 'Q3', color: Colors.green),
            ],
            graphTitle: 'Quarterly Expense Data',
            xAxisTitle: "Quarter",
            yAxisTitle: "Expense",
          )),
  Chart(
      name: "Area Graph Overlapping",
      builder: () => OverlappingAreaGraph(
            dataSeries: [
              [1, 3, 4, 5, 6, 2, 1],
              [3.5, 4, 5.5, 6.5, 3.4, 2.5, 1.0],
              [2, 2.5, 4.5, 5.5, 6.5, 4.5, 3.5],
            ],
            lineColors: [Colors.blue, Colors.blueGrey, Colors.green],
            fillColors: [Colors.blue, Colors.blueGrey, Colors.green],
            labels: [
              Legend(label: 'Coal', color: Colors.blue),
              Legend(label: 'Hydro', color: Colors.blueGrey),
              Legend(label: 'Gas', color: Colors.green),
            ],
            graphTitle: 'Monthly Expense Data',
            xAxisTitle: "Quarter",
            yAxisTitle: "Expense",
          )),
]);
