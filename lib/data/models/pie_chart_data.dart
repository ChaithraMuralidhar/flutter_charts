
class Data {
  Data(this.language, this.val);
  final String language;
  final double val;
}

 List<Data> getChartData() {
    final List<Data> chartData = [
      Data('Java', 4000),
      Data('Swift ', 3500),
      Data('Kotlin', 1500),
      Data('Objective-C', 500),
      Data('React Native', 300),
      Data('Flutter', 200),
    ];
    return chartData;
  }