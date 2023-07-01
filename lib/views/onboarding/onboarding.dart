import 'package:flutter/material.dart';
import 'package:sea_cense/widgets/commonButtonWidget.dart';
import 'package:sea_cense/widgets/headerWidget.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const HeaderWidget(
              text: "Sea cense",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            CommonButtonWidget(
              text: "Sign in",
              size: MediaQuery.of(context).size.width / 1.3,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
            ),
            CommonButtonWidget(
              text: "Sign up",
              size: MediaQuery.of(context).size.width / 1.3,
            ),
          ],
        ),
      ),
    );
  }
}
