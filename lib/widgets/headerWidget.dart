import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String text;
  const HeaderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/onBoarding_header_bg.png',
            height: 400,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 40),
            width: MediaQuery.of(context).size.width / 2.2,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo_without_text.png',
                  height: 100,
                ),
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
