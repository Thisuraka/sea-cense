import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sea_cense/models/base_api_response.dart';
import 'package:sea_cense/service/cucumber_service.dart';
import 'package:sea_cense/style.dart';
import 'package:sea_cense/utils/camera_helper.dart';
import 'package:sea_cense/utils/enums/processor_type.dart';
import 'package:sea_cense/widgets/common_button_widget.dart';

class CucumberViewModel extends ChangeNotifier {
  final CucumberService service = CucumberService();
  XFile? imageFile;

  bool isGen = false;

  void setGen() {
    isGen = !isGen;
  }

  Future<void> addImage(BuildContext context, ProcessorType processorType) async {
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
                onTap: () {
                  switch (processorType) {
                    case ProcessorType.live:
                      break;
                    case ProcessorType.processed:
                      // do something
                      break;
                    case ProcessorType.price:
                      // do something
                      break;
                    case ProcessorType.juvenile:
                      // do something
                      break;
                  }
                },
              ),
            ]),
          ),
        );
      },
    );
    setGen();
  }

  void liveProcess({required VoidCallback onSuccess}) async {
    BaseAPIResponse response = await service.uploadImage(imageFile!);
    if (response.error) {
    } else {
      // print('Token from sign in ${response.data['token']}');
      // User.fromJson(response.data["kefuInfo"]);
      // await SharedPreference.setAccessToken(response.data['token']);

      // WebSocket().connect(response.data['token']);

      // String message = jsonEncode({
      //   "data": {"id": await SharedPreference.getUserId()},
      //   "type": "to_chat"
      // });
      // WebSocket().send(message);
      // loginBtnText = 'customerService.login';
      notifyListeners();
      onSuccess();
    }
  }
}
