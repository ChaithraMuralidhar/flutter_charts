import 'package:flutter/material.dart';
import 'package:charts_painter/chart.dart';
import 'package:charts_graphs/presentation/area-graph_charts/area_graph_legend.dart';
import 'package:charts_graphs/presentation/area-graph_charts/area_graph_classes.dart';

import 'package:flutter/material.dart';
import 'package:charts_painter/chart.dart';


class AreaGraphGradient extends StatelessWidget {
  final List<List<num>> dataSeries;
  final List<Color> lineColors;
  final List<Color> fillColors;
  final List<Legend> labels;
  final List<List<Color>> gradientPair;
  final String graphTitle;
  final String xAxisTitle;
  final String yAxisTitle;

  AreaGraphGradient({
    required this.dataSeries,
    required this.lineColors,
    required this.fillColors,
    required this.labels,
    required this.gradientPair,
     required this.graphTitle,
      required this.xAxisTitle,
      required this.yAxisTitle

  });

  @override
  Widget build(BuildContext context) {
    List<List<ChartItem>> chartSeries = dataSeries
        .map((series) =>
            series.map((value) => ChartItem(value as double?)).toList())
        .toList();

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              graphTitle,
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ),
        Expanded(
          child: Row(
            children: [
              Align(
                alignment: Alignment.center,
                child: Transform.rotate(angle: -1.57,child: Text(yAxisTitle),)),
              Expanded(
                child: Stack(
                  children: [
                    LineChart<void>.multiple(
                      chartSeries,
                      height: MediaQuery.of(context).size.height * 0.4,
                      lineWidth: 2.0,
                      chartItemOptions: BubbleItemOptions(maxBarWidth: 0.0),
                      smoothCurves: true,
                      backgroundDecorations: [
                        CustomGridDecoration(
                          horizontalLabels: labels.map((legend) => legend.label).toList(),
                          showVerticalGrid: true,
                          showHorizontalGrid: true,
                          showTopHorizontalValue: true,
                          showVerticalValues: true,
                          showHorizontalValues: true,
                          horizontalLegendPosition: HorizontalLegendPosition.end,
                          verticalLegendPosition: VerticalLegendPosition.bottom,
                          horizontalAxisStep: 1,
                          textStyle: Theme.of(context).textTheme.caption,
                          gridColor: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.2),
                        ),
                        ...List.generate(chartSeries.length, (index) {
                          return SparkLineDecoration(
                            id: 'series_${index}_fill',
                            smoothPoints: true,
                            fill: false,
                            lineColor: fillColors[index].withOpacity(0.4),
                            listIndex: index,
                          );
                        }),
                      ],
                      foregroundDecorations: List.generate(chartSeries.length, (index) {
                        return SparkLineDecoration(
                          id: 'series_${index}_line',
                          lineWidth: 2.0,
                          fill: true,
                          smoothPoints: true,
                          gradient: LinearGradient(begin:Alignment.centerLeft,end:Alignment.centerRight,colors: gradientPair[index]),
                          lineColor: lineColors[index],
                          listIndex: index,
                        );
                      }),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          direction: Axis.vertical,
                          spacing: 16,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: labels,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                          SizedBox(width: 30,)

            ],
          ),
        ),
         Padding(
           padding: const EdgeInsets.symmetric(vertical: 8),
           child: Text(
             xAxisTitle,
             style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),
           ),)
      ],
    );
  }
}
