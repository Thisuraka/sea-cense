import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sea_cense/style.dart';
import 'package:sea_cense/utils/camera_helper.dart';
import 'package:sea_cense/utils/enums/processor_type.dart';
import 'package:sea_cense/viewmodels/cucumber_viewmodel.dart';
import 'package:sea_cense/widgets/common_button_widget.dart';
import 'package:sea_cense/widgets/home_tile_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Consumer<CucumberViewModel>(builder: (context, model, child) {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home_bg.png"),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo_without_text.png',
                      height: 100,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Sea Sence',
                      style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w200),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  HomeTileWidget(
                    icon: Icons.waves,
                    title: 'Live',
                    onTap: () {
                      model.addImage(context, ProcessorType.live);
                    },
                  ),
                  HomeTileWidget(
                    icon: Icons.dashboard,
                    title: 'Processed',
                    onTap: () {
                      model.addImage(context, ProcessorType.processed);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  HomeTileWidget(
                    icon: Icons.price_check,
                    title: 'Price',
                    onTap: () {},
                  ),
                  HomeTileWidget(
                    icon: Icons.new_label,
                    title: 'Juvenile',
                    onTap: () {
                      model.addImage(context, ProcessorType.juvenile);
                    },
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
