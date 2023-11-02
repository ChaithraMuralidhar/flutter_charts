import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/bar_chart_data.dart' as model;

import '../widgets/legends.dart';

class BarChart extends StatefulWidget {
  const BarChart({
    super.key,
    this.barRodWidth,
    this.showLegends = false,
    this.stacked = false,
    this.alignment = Axis.vertical,
    this.primaryColor = Colors.blue,
    required this.data,
    this.onTap,
    this.tooltip,
    this.tooltipData,
    this.xaxisLabel,
    this.yaxisLabel,
    this.title,
    this.titleStyle,
    this.description,
    this.descriptionStyle,
    this.fillColor,
    this.showAsPercentage = false,
    this.legendsPosition = LegendsPosition.top,
    this.gridColor = Colors.grey,
  });

  final double? barRodWidth;
  final bool showLegends;
  final bool stacked;
  final String? title;
  final String? description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final String? xaxisLabel;
  final String? yaxisLabel;
  final model.BarChartData data;
  final Axis alignment;
  final Color primaryColor;
  final LegendsPosition legendsPosition;
  final void Function(
    model.BarChartDataItem data,
    charts.BarChartRodData? rodData,
  )? onTap;
  final charts.BarTouchTooltipData? tooltipData;
  final charts.BarTooltipItem? Function(
      model.BarChartDataItem, charts.BarChartRodData?)? tooltip;
  final Color? Function(int index, List<model.BarChartDataItem> data)?
      fillColor;
  final Color gridColor;
  final bool? showAsPercentage;

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  Map<String, List<model.BarChartDataItem>> groupsData = {};
  Set<String> activeLegends = {};
  List<model.BarChartCategory>? groups;
  bool legendsInteracted = false;

  late Widget legendsListWidget;

  List<model.BarChartDataItem> series = [];
  final colors = [
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.indigo,
    Colors.cyan,
  ];

  @override
  void initState() {
    super.initState();

    groups = widget.data.categoriesData
      ?..retainWhere((element) => widget.data.series
          .map((e) => e.category)
          .toList()
          .contains(element.category));

    groups ??= [];

    final uniqueGroups =
        widget.data.series.map((e) => e.category ?? 'Unnamed').toSet().toList();

    groups?.addAll(
      List.generate(
        uniqueGroups.length,
        (index) => model.BarChartCategory(
          category: uniqueGroups.elementAt(index),
          color: colors.elementAt(index % colors.length),
        ),
      )..removeWhere((element) => groups?.contains(element) == true),
    );

    if (groups?.isEmpty == true ||
        widget.data.series
            .where((element) => element.category == null)
            .isNotEmpty) {
      groups = [
        ...?groups,
        model.BarChartCategory(category: 'Unnamed'),
      ];
    }

    activeLegends = groups!.map((e) => e.category).toSet();

    Future.microtask(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          series = widget.data.series;
        });
      });
    });

    legendsListWidget = LegendsListWidget(
      legends: List.generate(
        groups?.length ?? 0,
        (index) => Legend(
          groups!.elementAt(index).category,
          groups!.elementAt(index).color ?? widget.primaryColor,
        ),
      ),
      onChange: (selected) {
        setState(() {
          legendsInteracted = true;
          activeLegends = selected.map((e) => e.name).toSet();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (cpntext, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.title != null || widget.description != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Column(
                  children: [
                    if (widget.title != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          widget.title!,
                          style: widget.titleStyle ?? textTheme.titleLarge,
                        ),
                      ),
                    if (widget.description != null)
                      Text(
                        widget.description!,
                        style: widget.descriptionStyle ?? textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
            if (widget.showLegends &&
                widget.legendsPosition == LegendsPosition.top)
              legendsListWidget,
            const SizedBox(height: 20),
            Expanded(child: _buildChart(context, constraints)),
            if (widget.showLegends &&
                widget.legendsPosition == LegendsPosition.bottom)
              legendsListWidget,
          ],
        );
      },
    );
  }

  Widget _buildChart(BuildContext context, BoxConstraints constraints) {
    return RotatedBox(
      quarterTurns: widget.alignment == Axis.vertical ? 0 : 1,
      child: LayoutBuilder(
        builder: (_, chartConstraints) {
          var textTheme = Theme.of(context).textTheme;
          return Stack(
            fit: StackFit.expand,
            children: [
              Row(
                children: [
                  if (widget.showLegends &&
                      widget.legendsPosition == LegendsPosition.left)
                    Expanded(flex: 2, child: legendsListWidget),
                  if (widget.yaxisLabel != null &&
                      widget.alignment == Axis.vertical)
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        widget.yaxisLabel ?? '',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Expanded(
                          child: charts.BarChart(
                            charts.BarChartData(
                              barTouchData: charts.BarTouchData(
                                touchCallback: (_, response) {
                                  response?.spot;
                                  final groupIndex =
                                      response?.spot?.touchedBarGroupIndex;
                                  final itemIndex =
                                      response?.spot?.touchedRodDataIndex;

                                  if (groupIndex != null && itemIndex != null) {
                                    final item = groupsData.entries
                                        .elementAt(groupIndex)
                                        .value
                                        .elementAt(itemIndex);

                                    widget.onTap?.call(
                                      item,
                                      response?.spot?.touchedRodData,
                                    );
                                  }
                                },
                                touchTooltipData: charts.BarTouchTooltipData(
                                  rotateAngle: widget.alignment == Axis.vertical
                                      ? 0
                                      : -90,
                                  fitInsideHorizontally: true,
                                  fitInsideVertically: true,
                                  tooltipRoundedRadius: 6,
                                  getTooltipItem:
                                      (_, groupIndex, rod, rodIndex) {
                                    final item = groupsData.entries
                                        .elementAt(groupIndex)
                                        .value
                                        .elementAt(rodIndex);

                                    return widget.tooltip?.call(item, rod) ??
                                        charts.BarTooltipItem(
                                          '${item.x}\n',
                                          const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                          children: <TextSpan>[
                                            if (item.category != null)
                                              TextSpan(
                                                text: '${item.category}: ',
                                                style: TextStyle(
                                                  color:
                                                      rod.color ?? Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            TextSpan(
                                              text: NumberFormat.compact(
                                                locale: "en_IN",
                                              ).format(item.y).toString(),
                                              style: TextStyle(
                                                color:
                                                    rod.color ?? Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        );
                                  },
                                ),
                              ),
                              barGroups: _barBuilder(
                                series,
                                activeLegends,
                                context,
                                widget.alignment == Axis.horizontal
                                    ? chartConstraints.maxHeight
                                    : chartConstraints.maxWidth,
                              ),
                              gridData: charts.FlGridData(
                                show: true,
                                checkToShowHorizontalLine: (value) =>
                                    value % 10 == 0,
                                getDrawingHorizontalLine: (value) {
                                  return charts.FlLine(
                                    color: widget.gridColor,
                                    strokeWidth: .5,
                                  );
                                },
                                drawVerticalLine: false,
                              ),
                              titlesData: charts.FlTitlesData(
                                rightTitles: widget.alignment == Axis.horizontal
                                    ? charts.AxisTitles(
                                        sideTitles: charts.SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            var f = NumberFormat.compact(
                                              locale: "en_IN",
                                            );

                                            return Transform.rotate(
                                              angle: -pi / 2,
                                              child: Text(
                                                f.format(value),
                                                style: const TextStyle(
                                                    fontSize: 10),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : charts.AxisTitles(),
                                leftTitles: widget.alignment == Axis.horizontal
                                    ? charts.AxisTitles()
                                    : null,
                                topTitles: charts.AxisTitles(),
                                bottomTitles: charts.AxisTitles(
                                  sideTitles: charts.SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: getTitles,
                                    reservedSize: 38,
                                  ),
                                ),
                              ),
                              borderData: charts.FlBorderData(
                                show: true,
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey.withOpacity(.4),
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.grey.withOpacity(.4),
                                  ),
                                ),
                              ),
                            ),
                            swapAnimationDuration:
                                const Duration(milliseconds: 500),
                            swapAnimationCurve: Curves.linear,
                          ),
                        ),
                        if (widget.xaxisLabel != null)
                          Center(
                            child: RotatedBox(
                              quarterTurns:
                                  widget.alignment == Axis.vertical ? 0 : 2,
                              child: Text(
                                widget.xaxisLabel!,
                                style: textTheme.bodySmall,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.yaxisLabel != null &&
                      widget.alignment == Axis.horizontal)
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        widget.yaxisLabel ?? '',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  if (widget.showLegends &&
                      widget.legendsPosition == LegendsPosition.right)
                    Expanded(flex: 2, child: legendsListWidget),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  List<charts.BarChartGroupData>? _barBuilder(
    List<model.BarChartDataItem> series,
    Set<String> activeLegends,
    BuildContext context,
    double width,
  ) {
    groupsData = {};

    var computedSeries = [...series]..removeWhere((element) {
        if (element.category == null) {
          return !legendsInteracted && activeLegends.isEmpty
              ? false
              : !activeLegends.contains('Unnamed');
        } else {
          return !activeLegends.contains(element.category);
        }
      });

    if (legendsInteracted && activeLegends.isEmpty) {
      computedSeries = [];
    }

    for (var element in computedSeries) {
      if (groupsData.containsKey(element.x)) {
        groupsData[element.x]?.add(element);
      } else {
        groupsData[element.x] = [element];
      }
    }

    return List.generate(groupsData.length, (index) {
      final entries = groupsData[groupsData.keys.elementAt(index)]!
        ..sort((a, b) => a.y.compareTo(b.y));
      final max = entries.map((e) => e.y).max;
      final y = entries
          .map((e) => widget.showAsPercentage == true ? (e.y / max) * 100 : e.y)
          .toList();

      return charts.BarChartGroupData(
        x: index,
        groupVertically: widget.stacked,
        barRods: List.generate(
          entries.length,
          (eindex) {
            var entry = entries.elementAt(eindex);
            final color = widget.fillColor?.call(index, widget.data.series) ??
                (groups
                        ?.firstWhere(
                          (element) => element.category == entry.category,
                          orElse: () => model.BarChartCategory(
                            category: '',
                            color: widget.primaryColor,
                          ),
                        )
                        .color ??
                    widget.primaryColor);
            var calculatedWidth = widget.barRodWidth ??
                width /
                    (groupsData.length *
                        groupsData.entries.map((e) => e.value.length).sum);

            if (widget.barRodWidth == null && widget.stacked == true) {
              calculatedWidth = width / (groupsData.length * 2);
            }

            return charts.BarChartRodData(
              fromY: widget.stacked && eindex != 0
                  ? y.elementAt(eindex - 1)
                  : null,
              toY: y.elementAt(eindex).toDouble(),
              borderRadius: BorderRadius.zero,
              width: widget.alignment == Axis.horizontal
                  ? null
                  : calculatedWidth <= 0
                      ? 4
                      : calculatedWidth,
              color: widget.fillColor?.call(index, widget.data.series) != null
                  ? color
                  : eindex != 0 && widget.stacked && groups?.length == 1
                      ? _getSteppedColor(
                          color: color,
                          index: eindex,
                          steps: (eindex + 1) * 2,
                        )
                      : color,
            );
          },
        ),
      );
    });
  }

  Widget getTitles(double value, charts.TitleMeta meta) {
    const style = TextStyle(
      fontSize: 16,
    );
    final labels = widget.data.series.map((e) => e.x).toSet();

    Widget text = RotatedBox(
      quarterTurns: widget.alignment == Axis.vertical ? 0 : 3,
      child: AutoSizeText(
        labels.elementAt(value.toInt()),
        style: style,
        minFontSize: 10,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );

    return charts.SideTitleWidget(
      axisSide: charts.AxisSide.left,
      child: text,
    );
  }

  Color _getSteppedColor({
    required Color color,
    required int index,
    required int steps,
  }) {
    final fraction = index / steps;
    return Color.fromRGBO(
      color.red + ((255 - color.red) * fraction).round(),
      color.green + ((255 - color.green) * fraction).round(),
      color.blue + ((255 - color.blue) * fraction).round(),
      color.opacity + ((255 - color.opacity) * fraction).round(),
    );
  }
}
