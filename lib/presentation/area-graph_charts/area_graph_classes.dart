import 'dart:math';

import 'package:charts_painter/chart.dart';

import 'package:flutter/material.dart';

typedef DataToValue<T> = double Function(T item);
typedef DataToAxis<T> = String Function(int item);

class LineChart<T> extends StatelessWidget {
  LineChart({
    required List<T> data,
    required DataToValue<T> dataToValue,
    this.height = 240.0,
    this.lineWidth = 2.0,
    this.itemColor = Colors.red,
    this.backgroundDecorations = const [],
    this.foregroundDecorations = const [],
    this.chartItemOptions,
    this.chartBehaviour = const ChartBehaviour(),
    this.smoothCurves = false,
    this.gradient,
    this.stack = false,
    Key? key,
  })  : _mappedValues = [
          data.map((e) => ChartItem<T>(dataToValue(e))).toList()
        ],
        super(key: key);

  LineChart.multiple(
    this._mappedValues, {
    this.height = 240.0,
    this.lineWidth = 2.0,
    this.itemColor = Colors.red,
    this.backgroundDecorations = const [],
    this.foregroundDecorations = const [],
    this.chartItemOptions,
    this.chartBehaviour = const ChartBehaviour(),
    this.smoothCurves = false,
    this.gradient,
    this.stack = false,
    Key? key,
  }) : super(key: key);

  final double height;

  final bool smoothCurves;
  final Color itemColor;
  final Gradient? gradient;
  final double lineWidth;
  final bool stack;

  final List<DecorationPainter> backgroundDecorations;
  final List<DecorationPainter> foregroundDecorations;
  final ChartBehaviour chartBehaviour;
  final ItemOptions? chartItemOptions;

  final List<List<ChartItem<T>>> _mappedValues;

  @override
  Widget build(BuildContext context) {
    return AnimatedChart<T>(
      height: height,
      duration: const Duration(milliseconds: 450),
      state: ChartState<T>(
        data: ChartData(
          _mappedValues,
          dataStrategy: stack
              ? StackDataStrategy()
              : DefaultDataStrategy(stackMultipleValues: true),
        ),
        itemOptions: chartItemOptions ??
            BarItemOptions(barItemBuilder: (_) => BarItem()),
        foregroundDecorations: [
          SparkLineDecoration(
            id: 'chart_decoration',
            lineWidth: lineWidth,
            lineColor: itemColor,
            gradient: gradient,
            smoothPoints: smoothCurves,
          ),
          ...foregroundDecorations,
        ],
        backgroundDecorations: [
          ...backgroundDecorations,
        ],
      ),
    );
  }
}

class ChartOptionsWidget extends StatefulWidget {
  ChartOptionsWidget({
    required this.onRefresh,
    required this.toggleItems,
    required this.onAddItems,
    required this.onRemoveItems,
    Key? key,
  }) : super(key: key);

  final VoidCallback onRefresh;
  final VoidCallback onAddItems;
  final VoidCallback onRemoveItems;
  final List<Widget> toggleItems;

  @override
  _ChartOptionsWidgetState createState() => _ChartOptionsWidgetState();
}

class _ChartOptionsWidgetState extends State<ChartOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            
          ],
        ),
        Row(
          children: [
            Flexible(
              child: ToggleItem(
                value: true,
                title: 'Slow animations',
                onChanged: (value) {
                  setState(() {
                  });
                },
              ),
            ),
           
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Text(
              'OPTIONS',
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: Theme.of(context).disabledColor),
            ),
          ),
        ),
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Flexible(
          child: ListView(
            children: widget.toggleItems,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}

class ToggleItem extends StatelessWidget {
  ToggleItem(
      {required this.title,
      required this.value,
      required this.onChanged,
      Key? key})
      : super(key: key);

  final bool value;
  final String title;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SwitchListTile(
        value: value,
        title: Text(title),
        onChanged: onChanged,
      ),
    );
  }
}

class CustomGridDecoration extends GridDecoration {
  final List<String> horizontalLabels;

  CustomGridDecoration({
    required this.horizontalLabels,
    bool showVerticalGrid = false,
    bool showHorizontalGrid = false,
    bool showTopHorizontalValue = false,
    bool showVerticalValues = false,
    bool showHorizontalValues = false,
    HorizontalLegendPosition horizontalLegendPosition =
        HorizontalLegendPosition.end,
    VerticalLegendPosition verticalLegendPosition = VerticalLegendPosition.top,
    double horizontalAxisStep = 1,
    TextStyle? textStyle,
    Color gridColor = Colors.grey,
  }) : super(
            showVerticalGrid: showVerticalGrid,
            showHorizontalGrid: showHorizontalGrid,
            showTopHorizontalValue: showTopHorizontalValue,
            showVerticalValues: showVerticalValues,
            showHorizontalValues: showHorizontalValues,
            horizontalLegendPosition: horizontalLegendPosition,
            verticalLegendPosition: verticalLegendPosition,
            horizontalAxisStep: horizontalAxisStep,
            textStyle: textStyle,
            gridColor: gridColor);

  @override
  void drawHorizontalLegend({
    required Canvas canvas,
    required Size size,
    required double step,
    required double gridWidth,
    required double horizontalStart,
  }) {
    final double height = size.height;
    final double width = size.width;
    final double verticalStep = height / (horizontalLabels.length - 1);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < horizontalLabels.length; i++) {
      final yOffset = height - i * verticalStep;
      textPainter.text = TextSpan(
        text: horizontalLabels[i],
        style: TextStyle(),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(horizontalStart - textPainter.width - 8,
            yOffset - textPainter.height / 2),
      );
    }
  }
}
