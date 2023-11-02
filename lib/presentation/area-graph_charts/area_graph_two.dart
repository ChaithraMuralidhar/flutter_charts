import 'dart:math';
import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'area_graph_classes.dart';


class AreaGraphTwo extends StatefulWidget {
  AreaGraphTwo({Key? key}) : super(key: key);

  @override
  _AreaGraphTwoState createState() => _AreaGraphTwoState();
}

class _AreaGraphTwoState extends State<AreaGraphTwo> {

  Map<int, List<ChartItem>> _values = <int, List<ChartItem>>{};
  List <ChartItem> valll=<ChartItem>[
    ChartItem(2),
    ChartItem(3),
    ChartItem(4),
    ChartItem(5),
    ChartItem(6),
    ChartItem(7),
    ChartItem(8)
  ];
  double targetMax = 0;
  bool _showValues = true;
  bool _smoothPoints = true;
  bool _fillLine = true;
  bool _showLine = true;
  bool _stack = true;
  int minItems = 15;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Stack(
                  children: [
                    LineChart<void>.multiple(
                      [valll,valll,valll],
                      stack: _stack,
                      height: MediaQuery.of(context).size.height * 0.4,
                      itemColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(_showLine ? 1.0 : 0.0),
                      lineWidth: 2.0,
                      chartItemOptions: BubbleItemOptions(
                        maxBarWidth: _showLine ? 0.0 : 6.0,
                        bubbleItemBuilder: (data) => BubbleItem(
                            color: [
                          Colors.black,
                          Colors.red,
                          Colors.blue
                        ][data.listIndex]),
                      ),
                      smoothCurves: _smoothPoints,
                      backgroundDecorations: [
                        GridDecoration(
                          showVerticalGrid: true,
                          showHorizontalGrid: true,
                          showTopHorizontalValue: _showValues,
                          showVerticalValues: _showValues,
                          showHorizontalValues: _showValues,
                          horizontalAxisStep: _stack ? 3 : 1,
                          textStyle: Theme.of(context).textTheme.caption,
                          gridColor: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.2),
                        ),
                        SparkLineDecoration(
                          id: 'first_line_fill',
                          smoothPoints: _smoothPoints,
                          fill: true,
                          lineColor: Colors.purple
                              .withOpacity(_fillLine
                                  ? _stack
                                      ? 1.0
                                      : 0.2
                                  : 0.0),
                          listIndex: 0,
                        ),
                        SparkLineDecoration(
                          id: 'second_line_fill',
                          smoothPoints: _smoothPoints,
                          fill: true,
                          lineColor: Colors.green
                              .withOpacity(_fillLine
                                  ? _stack
                                      ? 1.0
                                      : 0.2
                                  : 0.0),
                          listIndex: 1,
                        ),
                        SparkLineDecoration(
                          id: 'third_line_fill',
                          smoothPoints: _smoothPoints,
                          fill: true,
                          
                          lineColor: Colors.blueAccent
                              .withOpacity(_fillLine
                                  ? _stack
                                      ? 1.0
                                      : 0.2
                                  : 0.0),
                          listIndex: 2,
                        ),
                      ],
                      foregroundDecorations: [
                        SparkLineDecoration(
                          id: 'second_line',
                          lineWidth: 2.0,
                          smoothPoints: _smoothPoints,
                          lineColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(_showLine ? 1.0 : 0.0),
                          listIndex: 1,
                        ),
                        SparkLineDecoration(
                          id: 'third_line',
                          lineWidth: 2.0,
                          smoothPoints: _smoothPoints,
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: Colors.accents),
                          lineColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(_showLine ? 1.0 : 0.0),
                          listIndex: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}


