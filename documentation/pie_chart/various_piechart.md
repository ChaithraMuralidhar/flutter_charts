### Various Pie Charts 
![name](https://images.edrawsoft.com/articles/create-pie-chart/blank-pie-chart.png)


#### How to use

* import 'package:syncfusion_flutter_charts/charts.dart';

* The SfCircularChart widget in the below code supports pie, doughnut, and radial bar series that can be customized within the circular chart's class.

```

Widget build(BuildContext context) {
 return Center(
   child:SfCircularChart(
   title: ChartTitle(text: ''),
   legend: Legend(isVisible: true),
    series: <CircularSeries>[
          PieSeries<Data, String>(
              dataSource: _chartData,
              xValueMapper: (Data data, _) => data.language,
              yValueMapper: (Data data, _) => data.val,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true),
        ],
  )
 );
}

class _PieData {
 _PieData(this.xData, this.yData, [this.text]);
 final String xData;
 final num yData;
 final String text;
}

```

* Add the chart elements such as title, legend, data label, and tooltip to display additional information about the data plotted in the chart.




