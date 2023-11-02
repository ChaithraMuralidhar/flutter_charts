import 'package:flutter/material.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({
    super.key,
    required this.name,
    required this.color,
  });
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xff757391),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class LegendsListWidget extends StatefulWidget {
  const LegendsListWidget({
    super.key,
    required this.legends,
    this.onChange,
  });

  final List<Legend> legends;
  final void Function(Set<Legend>)? onChange;

  @override
  State<LegendsListWidget> createState() => _LegendsListWidgetState();
}

class _LegendsListWidgetState extends State<LegendsListWidget> {
  Set<Legend> activeLegends = {};

  @override
  void initState() {
    super.initState();

    activeLegends = widget.legends.map((e) => e).toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: widget.legends
          .map(
            (e) => GestureDetector(
              onTap: () {
                setState(() {
                  if (activeLegends.contains(e)) {
                    activeLegends.remove(e);
                  } else {
                    activeLegends.add(e);
                  }
                });

                widget.onChange?.call(activeLegends);
              },
              child: Opacity(
                opacity: activeLegends.contains(e) ? 1 : .5,
                child: LegendWidget(
                  name: e.name,
                  color: e.color,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class Legend {
  Legend(this.name, this.color);
  final String name;
  final Color color;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Legend && other.name == name && other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ color.hashCode;
}

enum LegendsPosition { top, left, right, bottom }
