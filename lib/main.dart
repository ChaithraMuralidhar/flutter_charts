import 'package:charts_graphs/presentation/onboarding/onboarding.dart';
import 'package:charts_graphs/utils/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChanger(lightTheme)),
      ],
      child: const SplashScreen(),
    ),
  );
}
