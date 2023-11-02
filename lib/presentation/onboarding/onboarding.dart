import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:charts_graphs/app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Column(
          children: [
            Image.asset('lib/images/logo.png', height: 250, width: 250),
          ],
        ),
        duration: 2600,
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        backgroundColor: const Color(0xffc7b396),
        nextScreen: const App(),
        splashIconSize: 250,
      ),
    );
  }
}
