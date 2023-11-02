import 'package:flutter/cupertino.dart';

class Chart {
  String name;
  Widget? child;
  Widget Function()? builder;
  List<Chart>? types;

  Chart({
    required this.name,
    this.child,
    this.builder,
    this.types,
  });
}
