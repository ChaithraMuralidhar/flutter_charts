import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  final String label;
  final Color color;

  const Legend({Key? key, required this.label, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
