import 'package:charts_graphs/data/models/line_chart_data.dart';
import 'package:charts_graphs/utils/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartDemo extends StatelessWidget {
  const LineChartDemo(
      {super.key,
      required this.lineChartData,
      required this.isShowSpots,
      required this.lineColor,
      required this.lineAreaColor,
      required this.lineDotColor,
      required this.lineDotLabelColor});

  final LineChartsData lineChartData;
  final bool isShowSpots;
  final MaterialColor lineColor;
  final MaterialColor lineAreaColor;
  final MaterialColor lineDotColor;
  final MaterialColor lineDotLabelColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            lineChartData.xLabel,
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                lineChartData.yLabel,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: LineChart(
            data,
            swapAnimationDuration: const Duration(milliseconds: 250),
          ),
        ),
      ],
    );
  }

  LineTouchData get lineTouchData2 => LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: lineDotLabelColor,
          tooltipRoundedRadius: 8,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toString(),
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: lineDotColor,
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: 8,
                  strokeWidth: 2,
                  strokeColor: lineDotColor,
                  color: lineDotColor,
                ),
              ),
            );
          }).toList();
        },
        enabled: !isShowSpots,
      );
  FlGridData get gridData => FlGridData(show: false);
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    List<String> labels;
    labels = lineChartData.labels
        .map(
          (e) => e.xLabel,
        )
        .toList();
    text = Text(labels.elementAt(value.toInt()),
        style: style, textAlign: TextAlign.center);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    List<String> text;
    text = lineChartData.labels
        .map(
          (e) => e.yLabel,
        )
        .toList();
    return Text(text.elementAt(value.toInt()),
        style: style, textAlign: TextAlign.center);
    // return Text(text.elementAt(value.toInt() == 0 ? 0 : value.toInt() - 1),
    //     style: style, textAlign: TextAlign.center);
  }

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );
  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_2,
      ];
  List<int> get showIndexes => const [0, 1, 2, 3, 4];

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        showingIndicators: showIndexes,
        isCurved: true,
        color: lineColor.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: lineAreaColor.withOpacity(0.2),
        ),
        spots: lineChartData.spots,
      );

  LineChartData get data => LineChartData(
        lineTouchData: lineTouchData2,
        showingTooltipIndicators: showIndexes.map((index) {
          return ShowingTooltipIndicators([
            LineBarSpot(
                lineChartBarData2_2,
                lineBarsData2.indexOf(lineChartBarData2_2),
                lineChartBarData2_2.spots[index])
          ]);
        }).toList(),
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: lineChartData.maxX,
        maxY: lineChartData.maxY,
        minY: 0,
      );
}
