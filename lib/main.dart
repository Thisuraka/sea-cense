import 'package:flutter/material.dart';
import 'package:sea_cense/views/onboarding/info_view.dart';
import 'package:sea_cense/views/onboarding/onboarding.dart';
import 'package:sea_cense/views/onboarding/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnboardingView(),
    );
  }
}
