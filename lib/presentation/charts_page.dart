import 'package:charts_graphs/data/models/chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/theme_changer.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key, required this.charts, this.title});

  final List<Chart> charts;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    var cardColor = theme.getTheme.cardColor;
    final themeSwitcher = IconButton(
      onPressed: () {
        theme.setTheme(
          theme.getTheme == lightTheme ? darkTheme : lightTheme,
        );
      },
      icon: Icon(
          theme.getTheme == lightTheme ? Icons.dark_mode : Icons.light_mode),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Charts & Graphs'),
        actions: [themeSwitcher],
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final chart = charts.elementAt(index);

            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: Colors.black.withOpacity(.2),
                  width: .5,
                ),
                color: theme.getTheme == lightTheme
                    ? cardColor
                    : cardColor.withOpacity(.3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (chart.types != null &&
                        chart.types?.isNotEmpty == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChartsPage(
                            title: chart.name,
                            charts: chart.types!,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: AppBar(
                              title: Text(chart.name),
                              actions: [themeSwitcher],
                            ),
                            body: SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: chart.child ?? chart.builder?.call(),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: AbsorbPointer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chart.name,
                          style: theme.getTheme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: FittedBox(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.height / 3,
                              child: chart.child ?? chart.builder?.call(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: charts.length,
        ),
      ),
    );
  }
}
