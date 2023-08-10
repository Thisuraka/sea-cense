import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sea_cense/style.dart';
import 'package:sea_cense/utils/camera_helper.dart';
import 'package:sea_cense/widgets/common_button_widget.dart';
import 'package:sea_cense/widgets/home_tile_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  XFile? imageFile;
  bool isGen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
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
                    addImage();
                  },
                ),
                HomeTileWidget(
                  icon: Icons.dashboard,
                  title: 'Processed',
                  onTap: () {},
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
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void setGen() {
    isGen = !isGen;
  }

  Future<void> addImage() async {
    imageFile = await CameraHelper.selectImages();

    // ignore: use_build_context_synchronously
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.cancel,
                  color: defaultColor,
                  size: 30,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                margin: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(File(imageFile!.path)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CommonButtonWidget(
                text: "Continue",
                size: MediaQuery.of(context).size.width / 1.3,
                onTap: () {},
              ),
            ]),
          ),
        );
      },
    );
    setGen();
  }

  void removeImage(int index) {
    // TODO
  }
}
