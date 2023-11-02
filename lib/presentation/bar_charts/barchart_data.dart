import 'package:charts_graphs/presentation/widgets/legends.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/bar_chart_data.dart';
import '../../data/models/chart.dart';
import 'bar_chart.dart';
import 'package:fl_chart/fl_chart.dart' as fl;

BarChartDataItem? selectedData;

Chart get barcharts => Chart(
      name: 'Bar Charts',
      builder: () {
        return BarChart(
          data: BarChartData(
            series: simpleSeries,
          ),
          showLegends: false,
        );
      },
      types: [
        Chart(
          name: 'Basic Bar',
          builder: () {
            return BarChart(
              data: BarChartData(
                series: simpleSeries,
              ),
              barRodWidth: 15,
              showLegends: false,
            );
          },
        ),
        Chart(
          name: 'Basic Bar with Custom Color',
          builder: () {
            return BarChart(
              data: BarChartData(
                series: simpleSeriesAndNegative,
              ),
              primaryColor: Colors.indigo,
              fillColor: (index, data) {
                if (index == 3) {
                  return Colors.green;
                } else if (index == 2) {
                  return Colors.red;
                }

                return null;
              },
              showLegends: false,
            );
          },
        ),
        Chart(
          name: 'Bar with Click Handler',
          builder: () {
            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    Expanded(
                      child: BarChart(
                        data: BarChartData(
                          series: simpleSeriesWithNegativeValue,
                        ),
                        title: 'Sales report',
                        description: 'This years sales report',
                        xaxisLabel: 'Year',
                        yaxisLabel: 'Profit (\$)',
                        showLegends: false,
                        onTap: (data, rodData) {
                          setState(() {
                            selectedData = data;
                          });
                        },
                      ),
                    ),
                    Text('You selected $selectedData'),
                  ],
                );
              },
            );
          },
        ),
        Chart(
          name: 'Bar Chart With Multiple Series',
          builder: () {
            return AspectRatio(
              aspectRatio: 16 / 12,
              child: BarChart(
                title: 'Population of India by states',
                description: 'According to recent sesus',
                data: BarChartData(
                  series: populationData,
                ),
                yaxisLabel: 'Population',
                showLegends: true,
                alignment: Axis.horizontal,
              ),
            );
          },
        ),
        Chart(
          name: 'Bar with Custom Tooltip',
          builder: () {
            return BarChart(
              data: BarChartData(
                series: simpleSeriesWithNegativeValue,
              ),
              title: 'Sales report',
              description: 'This years sales report',
              xaxisLabel: 'Year',
              yaxisLabel: 'Profit (\$)',
              showLegends: false,
              tooltip: (data, rod) {
                return fl.BarTooltipItem(
                  '${data.x}\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: NumberFormat.compact(
                        locale: "en_IN",
                      ).format(data.y).toString(),
                      style: TextStyle(
                        color: rod?.color ?? Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        Chart(
          name: 'Stacked with Custom Category Color',
          builder: () {
            return BarChart(
              title: 'Movies',
              description: 'Movies distribution by genre',
              yaxisLabel: 'Number of movies',
              xaxisLabel: 'Year',
              data: BarChartData(
                series: stackedSeries,
                categoriesData: [
                  BarChartCategory(
                    category: 'General',
                    color: Colors.grey,
                  ),
                ],
              ),
              stacked: true,
              showLegends: true,
            );
          },
        ),
        Chart(
          name: 'Stacked with Percentage Scale',
          builder: () {
            return AspectRatio(
              aspectRatio: 16 / 14,
              child: BarChart(
                data: BarChartData(
                  series: populationAgeData,
                ),
                title: 'Population Age Structure',
                description: 'Age distribution by sub-region of Africa',
                yaxisLabel: 'Percentage',
                stacked: true,
                barRodWidth: 35,
                alignment: Axis.horizontal,
                showAsPercentage: true,
                showLegends: true,
                tooltip: (data, rod) {
                  final max = populationAgeData.map((e) => e.y).max;
                  return fl.BarTooltipItem(
                    '${data.x}\n',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${((data.y / max) * 100).toStringAsPrecision(2)}%',
                        style: TextStyle(
                          color: rod?.color ?? Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
        Chart(
          name: 'Grouped with Legends on bottom',
          builder: () {
            return BarChart(
              data: BarChartData(
                series: groupedSeries,
              ),
              title: 'Electronics Sales Report',
              description: '(by quarter)',
              yaxisLabel: 'Units Sold',
              xaxisLabel: '2022',
              showLegends: true,
              legendsPosition: LegendsPosition.bottom,
            );
          },
        ),
      ],
    );

var simpleSeries = [
  BarChartDataItem(x: '2015', y: 45000),
  BarChartDataItem(x: '2016', y: 25000),
  BarChartDataItem(x: '2017', y: 76000),
  BarChartDataItem(x: '2018', y: 54000),
];

var simpleSeriesAndNegative = [
  BarChartDataItem(x: '2015', y: 45000),
  BarChartDataItem(x: '2016', y: 25000),
  BarChartDataItem(x: '2017', y: -76000),
  BarChartDataItem(x: '2018', y: 124000),
];

var populationData = [
  BarChartDataItem(x: 'Uttar Pradesh', y: 199812341, category: '2023'),
  BarChartDataItem(x: 'Uttar Pradesh', y: 189812341, category: '2022'),
  BarChartDataItem(x: 'Maharashtra', y: 112374333, category: '2023'),
  BarChartDataItem(x: 'Maharashtra', y: 100374333, category: '2022'),
  BarChartDataItem(x: 'Bihar', y: 104099452, category: '2023'),
  BarChartDataItem(x: 'Bihar', y: 94099452, category: '2022'),
];

var simpleSeriesWithNegativeValue = [
  BarChartDataItem(x: '2015', y: 45000),
  BarChartDataItem(x: '2016', y: 25000),
  BarChartDataItem(x: '2017', y: 76000),
  // BarChartDataItem(x: '2018', y: -54000),
];

var stackedSeries = [
  BarChartDataItem(x: '2010', y: 10, category: 'Fantast & Sci-Fi'),
  BarChartDataItem(x: '2010', y: 24, category: 'Romance'),
  BarChartDataItem(x: '2010', y: 20, category: 'Mystry & Thriller'),
  BarChartDataItem(x: '2010', y: 32, category: 'General'),
  BarChartDataItem(x: '2010', y: 18, category: 'Western'),
  BarChartDataItem(x: '2010', y: 4, category: 'Documentry'),
  BarChartDataItem(x: '2011', y: 15, category: 'Fantast & Sci-Fi'),
  BarChartDataItem(x: '2011', y: 20, category: 'Romance'),
  BarChartDataItem(x: '2011', y: 14, category: 'Mystry & Thriller'),
  BarChartDataItem(x: '2011', y: 22, category: 'General'),
  BarChartDataItem(x: '2011', y: 24, category: 'Western'),
  BarChartDataItem(x: '2011', y: 8, category: 'Documentry'),
  BarChartDataItem(x: '2012', y: 14, category: 'Fantast & Sci-Fi'),
  BarChartDataItem(x: '2012', y: 15, category: 'Romance'),
  BarChartDataItem(x: '2012', y: 26, category: 'Mystry & Thriller'),
  BarChartDataItem(x: '2012', y: 35, category: 'General'),
  BarChartDataItem(x: '2012', y: 22, category: 'Western'),
  BarChartDataItem(x: '2012', y: 12, category: 'Documentry'),
];

var populationAgeData = [
  BarChartDataItem(x: 'Northern Africa', y: 33, category: 'Ages < 15'),
  BarChartDataItem(x: 'Northern Africa', y: 62, category: 'Ages 15 - 64'),
  BarChartDataItem(x: 'Northern Africa', y: 5, category: 'Ages 65+'),
  BarChartDataItem(x: 'Western Africa', y: 43, category: 'Ages < 15'),
  BarChartDataItem(x: 'Western Africa', y: 54, category: 'Ages 15 - 64'),
  BarChartDataItem(x: 'Western Africa', y: 3, category: 'Ages 65+'),
  BarChartDataItem(x: 'Eastern Africa', y: 41, category: 'Ages < 15'),
  BarChartDataItem(x: 'Eastern Africa', y: 52, category: 'Ages 15 - 64'),
  BarChartDataItem(x: 'Eastern Africa', y: 3, category: 'Ages 65+'),
  BarChartDataItem(x: 'Middle Africa', y: 29, category: 'Ages < 15'),
  BarChartDataItem(x: 'Middle Africa', y: 65, category: 'Ages 15 - 64'),
  BarChartDataItem(x: 'Middle Africa', y: 6, category: 'Ages 65+'),
];

var groupedSeries = [
  BarChartDataItem(x: 'Q1', y: 45, category: 'Laptop'),
  BarChartDataItem(x: 'Q1', y: 21, category: 'Mobiles'),
  BarChartDataItem(x: 'Q2', y: 76, category: 'Laptop'),
  BarChartDataItem(x: 'Q2', y: 33, category: 'Mobiles'),
  BarChartDataItem(x: 'Q3', y: 40, category: 'Laptop'),
  BarChartDataItem(x: 'Q3', y: 25, category: 'Mobiles'),
];

var groupedStackedSeries = [
  BarChartDataItem(x: 'Q1', y: 45, category: 'Laptop'),
  BarChartDataItem(x: 'Q1', y: 72, category: 'Laptop'),
  BarChartDataItem(x: 'Q1', y: 21, category: 'Mobiles'),
  BarChartDataItem(x: 'Q2', y: 76, category: 'Laptop'),
  BarChartDataItem(x: 'Q2', y: 33, category: 'Mobiles'),
  BarChartDataItem(x: 'Q2', y: 63, category: 'Mobiles'),
  BarChartDataItem(x: 'Q3', y: 40, category: 'Laptop'),
  BarChartDataItem(x: 'Q3', y: 25, category: 'Mobiles'),
];
