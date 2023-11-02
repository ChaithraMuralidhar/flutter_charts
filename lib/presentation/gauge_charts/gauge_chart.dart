import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class GaugeChart extends StatelessWidget {
  const GaugeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DChartGauge(
        data: const [
          {'domain': 'Off', 'measure': 30},
          {'domain': 'Warm', 'measure': 30},
          {'domain': 'Hot', 'measure': 30},
        ],
        fillColor: (pieData, index) {
          switch (pieData['domain']) {
            case 'Off':
              return Colors.green;
            case 'Warm':
              return Colors.orange;
            default:
              return Colors.red;
          }
        },
        donutWidth: 40,
        showLabelLine: true,
        pieLabel: (pieData, index) {
          return "${pieData['domain']}";
        },
        labelPosition: PieLabelPosition.inside,
        labelPadding: 0,
        labelColor: Colors.white,
      ),
    );
  }
}
