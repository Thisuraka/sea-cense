import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sea_cense/viewmodels/cucumber_viewmodel.dart';
import 'package:sea_cense/widgets/divider.dart';
import 'package:sea_cense/widgets/live_detail_row.dart';

class JuvenileCucumberDetails extends StatelessWidget {
  const JuvenileCucumberDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF1869C0),
            Color(0xFF443C6C),
          ], begin: Alignment.topLeft, end: Alignment.centerRight),
        ),
        child: Consumer<CucumberViewModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 20),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Juvenile Size Prediction",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xD2BBE4FF),
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3.0),
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
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Color(0x29000000),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.cucumberJuvenile!.initSize!,
                          style: const TextStyle(
                              color: Color(0xD20099FF),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Holothuria Scabra',
                          style: TextStyle(
                              color: Color(0xD2FFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                              letterSpacing: 3.0),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomDivider(),
                        LiveDetailRow(
                          title: 'Final Weight (g)',
                          desc: model.cucumberJuvenile!.weight!,
                        ),
                        LiveDetailRow(
                          title: 'Growth rate per day (%)',
                          desc: model.cucumberJuvenile!.growthRate!,
                        ),
                        LiveDetailRow(
                          title: 'Survival rate (%)',
                          desc: model.cucumberJuvenile!.survivalRate!,
                        ),
                        LiveDetailRow(
                          title: 'Total Biomass (g)',
                          desc: model.cucumberJuvenile!.totalBiomass!,
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
}
