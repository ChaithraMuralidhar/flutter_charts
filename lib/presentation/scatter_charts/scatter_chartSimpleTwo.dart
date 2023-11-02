import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class ScatterChartSimpleTwo extends StatelessWidget {
  final List<DChartScatterData> data1;
  final List<DChartScatterData> data2;
  const ScatterChartSimpleTwo(
      {super.key, required this.data1, required this.data2});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: DChartScatter(
                groupData: [
                  DChartScatterGroup(
                    id: 'id',
                    data: data1,
                    color: Colors.amber,
                  ),
                  DChartScatterGroup(
                    id: 'id2',
                    data: data2,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
