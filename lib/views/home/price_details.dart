import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sea_cense/viewmodels/cucumber_viewmodel.dart';
import 'package:sea_cense/widgets/divider.dart';
import 'package:sea_cense/widgets/live_detail_row.dart';

class PriceDetails extends StatelessWidget {
  const PriceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 24, 116, 192),
            Color.fromARGB(255, 60, 77, 108),
          ], begin: Alignment.topLeft, end: Alignment.centerRight),
        ),
        child: Consumer<CucumberViewModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 4,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.file(File(model.imageFile!.path)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Color(0x29000000),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                              letterSpacing: 3.0,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${getRandomDivisibleByFive(model.cucumberPrice!.price!)} LKR',
                          style: const TextStyle(
                              color: Color(0xD20099FF),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.0),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomDivider(),
                        LiveDetailRow(
                          title: 'Price range (LKR)',
                          desc: model.cucumberPrice!.price!,
                        ),
                        LiveDetailRow(
                          title: 'Length (cm)',
                          desc: model.cucumberPrice!.length!,
                        ),
                        LiveDetailRow(
                          title: 'Width (g)',
                          desc: model.cucumberPrice!.width!,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  int getRandomDivisibleByFive(String price) {
    List<String> priceParts = price.split('-');
    final random = Random();
    int result, min, max;
    min = int.parse(priceParts[0]);
    max = int.parse(priceParts[1]);

    do {
      result = min + random.nextInt(max - min + 1);

      result -= result % 5;
    } while (result < min);

    return result;
  }
}
