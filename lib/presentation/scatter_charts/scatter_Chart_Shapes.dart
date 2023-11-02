import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';

class ScatterChartShapes extends StatelessWidget {
  final List<DChartScatterData> data1;
  final List<DChartScatterData> data2;
  const ScatterChartShapes(
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
                borderWidth: (group, data, index) => 4,
                groupData: [
                  DChartScatterGroup(
                    id: 'id',
                    data: data1,
                    color: Color.fromARGB(255, 149, 206, 26),
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
