import '/data/models/scatter_chart_data.dart';
import './scatterchart_data_passing.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScatterNoCorrelationAnimation extends StatefulWidget {
  const ScatterNoCorrelationAnimation({
    super.key,
    required this.scatterChartData,
  });

  final ScattersChartData scatterChartData;

  @override
  State<StatefulWidget> createState() => _ScatterNoCorrelationAnimationState();
}

class _ScatterNoCorrelationAnimationState extends State {
  int touchedIndex = -1;

  Color greyColor = Colors.grey;

  List<int> selectedSpots = [];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ScatterChart(
        ScatterChartData(
          scatterSpots: scatterChartData.scatterSpots,
          // scatterLabelSettings: ScatterLabelSettings(
          //     // showLabel: true,

          //     // getLabelTextStyleFunction: (spotIndex, spot) {
          //     //   return TextStyle(
          //     //       // fontFamilyFallback: List.empty(),

          //     //       backgroundColor: Colors.amber,
          //     //       color: Color.fromARGB(255, 68, 55, 16));
          //     // },

          //     // textDirection: TextDirection.rtl,
          //     // getLabelTextStyleFunction
          //     // getLabelTextStyleFunction: (spotIndex, spot) {},
          //     ),

          backgroundColor: null,
          minX: scatterChartData.xAxisStart,
          maxX: scatterChartData.xAxisEnd,
          minY: scatterChartData.yAxisStart,
          maxY: scatterChartData.yAxisEnd,
          borderData: FlBorderData(
            show: true,
            border: Border(left: BorderSide(), bottom: BorderSide()),

            // border:
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            checkToShowHorizontalLine: (value) => true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Color.fromARGB(17, 204, 85, 85),
            ),
            drawVerticalLine: true,
            checkToShowVerticalLine: (value) => true,
            getDrawingVerticalLine: (value) => FlLine(
              color: Color.fromARGB(17, 246, 102, 102),
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(axisNameWidget: const Text("Sales")),
            rightTitles: AxisTitles(axisNameWidget: const Text("Product")),
            // bottomTitles: AxisTitles(axisNameWidget: Text("Product")),
            // leftTitles: AxisTitles(axisNameWidget: Text("abc")),
          ),

          // axisTitleData:FlAxisTitleData(touchedIndex:AboutDialog()),

          showingTooltipIndicators: selectedSpots,
          scatterTouchData: ScatterTouchData(
            enabled: true,
            handleBuiltInTouches: false,
            mouseCursorResolver:
                (FlTouchEvent touchEvent, ScatterTouchResponse? response) {
              return response == null || response.touchedSpot == null
                  ? MouseCursor.defer
                  : SystemMouseCursors.click;
            },
            touchTooltipData: ScatterTouchTooltipData(
              tooltipBgColor: Colors.black,
              getTooltipItems: (ScatterSpot touchedBarSpot) {
                return ScatterTooltipItem(
                  'Sales: ',
                  textStyle: TextStyle(
                    height: 1.2,
                    color: Colors.grey[100],
                    fontStyle: FontStyle.italic,
                  ),
                  bottomMargin: 10,
                  children: [
                    TextSpan(
                      text: '${touchedBarSpot.x.toInt()} \n',
                      style: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Product: ',
                      style: TextStyle(
                        height: 1.2,
                        color: Colors.grey[100],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: touchedBarSpot.y.toInt().toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
            touchCallback:
                (FlTouchEvent event, ScatterTouchResponse? touchResponse) {
              if (touchResponse == null || touchResponse.touchedSpot == null) {
                return;
              }
              if (event is FlTapUpEvent) {
                final sectionIndex = touchResponse.touchedSpot!.spotIndex;
                setState(() {
                  if (selectedSpots.contains(sectionIndex)) {
                    selectedSpots.remove(sectionIndex);
                  } else {
                    selectedSpots.add(sectionIndex);
                  }
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
