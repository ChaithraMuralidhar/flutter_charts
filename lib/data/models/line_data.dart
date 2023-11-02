class LineData {
  late double maxX;
  late double maxY;
  late String xLabel;
  late String yLabel;
  late List<Labels> labels;
  late List<Points> points;

  LineData.fromJson(Map<String, dynamic> json) {
    maxX = json['maxX'];
    maxY = json['maxY'];
    xLabel = json['xLabel'];
    yLabel = json['yLabel'];
    if (json['labels'] != null) {
      labels = <Labels>[];
      json['labels'].forEach((v) {
        labels.add(Labels.fromJson(v));
      });
    }
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maxX'] = maxX;
    data['maxY'] = maxY;
    data['xLabel'] = xLabel;
    data['yLabel'] = yLabel;
    data['labels'] = labels.map((v) => v.toJson()).toList();
    data['points'] = points.map((v) => v.toJson()).toList();
    return data;
  }
}

class Labels {
  late String xLabel;
  late String yLabel;

  Labels.fromJson(Map<String, dynamic> json) {
    xLabel = json['xLabel'];
    yLabel = json['yLabel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['xLabel'] = xLabel;
    data['yLabel'] = yLabel;
    return data;
  }
}

class Points {
  late double xPoint;
  late double yPoint;

  Points.fromJson(Map<String, dynamic> json) {
    xPoint = json['xPoint'];
    yPoint = json['yPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['xPoint'] = xPoint;
    data['yPoint'] = yPoint;
    return data;
  }
}
