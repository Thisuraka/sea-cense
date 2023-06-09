import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      // child: Image.asset('assets/images/splash_logo.png'),
      child: Center(
        child: Image.asset('assets/images/splash_logo.png')
            .animate()
            .fadeIn()
            .scale()
            .move(delay: 300.ms, duration: 600.ms),
      ),
    );
  }
}
