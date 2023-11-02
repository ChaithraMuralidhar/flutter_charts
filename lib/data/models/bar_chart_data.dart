import 'package:flutter/material.dart';

class BarChartData {
  final List<BarChartDataItem> series;
  final List<BarChartCategory>? categoriesData;

  BarChartData({
    required this.series,
    this.categoriesData,
  });
}

class BarChartCategory {
  final String category;
  Color? color;

  BarChartCategory({
    required this.category,
    this.color,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BarChartCategory && other.category == category;
  }

  @override
  int get hashCode => category.hashCode ^ color.hashCode;
}

class BarChartDataItem {
  final String x;
  final double y;
  final String? category;

  BarChartDataItem({
    required this.x,
    required this.y,
    this.category,
  });

  @override
  String toString() => 'BarChartDataItem(x: $x, y: $y, category: $category)';
}
