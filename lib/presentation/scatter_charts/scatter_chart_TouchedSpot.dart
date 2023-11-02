import 'dart:math';
import 'package:charts_graphs/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScatterTouchedSpot extends StatefulWidget {
  const ScatterTouchedSpot({super.key});

  @override
  State<StatefulWidget> createState() => _ScatterTouchedSpotState();
}

class _ScatterTouchedSpotState extends State {
  int touchedIndex = -1;

  Color greyColor = Colors.grey;

  List<int> selectedSpots = [];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ScatterChart(
        // swapAnimationDuration: Duration(seconds: 2),
        // swapAnimationCurve: Curves.linear, // Optional

        ScatterChartData(
          // scatterLabelSettings: ScatterLabelSettings(showLabel: true),

          // baselineX: true,
          scatterSpots: [
            ScatterSpot(
              4,
              4,
            ),
            ScatterSpot(
              2,
              5,
            ),
            ScatterSpot(
              4,
              5,
            ),
            ScatterSpot(
              8,
              6,
            ),
            ScatterSpot(
              5,
              7,
            ),
            ScatterSpot(
              7,
              2,
            ),
            ScatterSpot(
              3,
              2,
            ),
            ScatterSpot(
              2,
              8,
            ),
          ],
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 10,
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
              color: Color.fromARGB(17, 75, 148, 250),
            ),
            drawVerticalLine: true,
            checkToShowVerticalLine: (value) => true,
            getDrawingVerticalLine: (value) => FlLine(
              color: Color.fromARGB(17, 246, 102, 102),
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(axisNameWidget: Text("abc")),
            leftTitles: AxisTitles(axisNameWidget: Text("abc")),
            show: true,
            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),

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
                  'X: ',
                  textStyle: TextStyle(
                    height: 1.2,
                    color: Colors.grey[100],
                    fontStyle: FontStyle.italic,
                  ),
                  textDirection: TextDirection.rtl,
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
                      text: 'Y: ',
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
