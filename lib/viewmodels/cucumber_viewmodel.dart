import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sea_cense/models/base_api_response.dart';
import 'package:sea_cense/models/cucumber_juvenile.dart';
import 'package:sea_cense/models/cucumber_live.dart';
import 'package:sea_cense/service/cucumber_service.dart';
import 'package:sea_cense/style.dart';
import 'package:sea_cense/utils/camera_helper.dart';
import 'package:sea_cense/utils/enums/processor_type.dart';
import 'package:sea_cense/utils/identity_data.dart';
import 'package:sea_cense/utils/navigation_service.dart';
import 'package:sea_cense/utils/urls.dart';
import 'package:sea_cense/utils/utils.dart';
import 'package:sea_cense/views/home/juvenile_cucumber_details.dart';
import 'package:sea_cense/views/home/live_cucumber_details.dart';
import 'package:sea_cense/widgets/common_button_widget.dart';

class CucumberViewModel extends ChangeNotifier {
  final CucumberService service = CucumberService();
  CucumberLive? foundCucumberForLive;
  CucumberJuvenile? cucumberJuvenile;
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
                      liveProcess(onSuccess: () {
                        Navigator.pop(context);
                        Navigator.of(NavigationService.navigatorKey.currentContext!)
                            .push(MaterialPageRoute(builder: (context) => const LiveCucumberDetails()));
                      });
                      break;
                    case ProcessorType.processed:
                      // do something
                      break;
                    case ProcessorType.price:
                      // do something
                      break;
                    case ProcessorType.juvenile:
                      juvenileProcess();
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
    Function(int, int)? onSendProgress;
    BaseAPIResponse response =
        await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getLiveEndpoint());
    if (response.error) {
      Utils.showSnackBar(
          'Something went wrong -- ${response.status}', NavigationService.navigatorKey.currentContext!);
    } else {
      try {
        foundCucumberForLive = seaCucumbers.firstWhere(
          (cucumber) => cucumber.type == response.data['data']['predicted_class'],
        );
        notifyListeners();
        onSuccess();
      } catch (e) {
        Utils.showSnackBar('Something went wrong', NavigationService.navigatorKey.currentContext!);
      }
    }
  }

  void juvenileProcess() async {
    Function(int, int)? onSendProgress;
    BaseAPIResponse response =
        await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getJuvenileEndpoint());
    if (response.error) {
      Utils.showSnackBar(
          'Something went wrong -- ${response.status}', NavigationService.navigatorKey.currentContext!);
    } else {
      try {
        if (response.data['data'] == "Adult") {
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          juvenileAdultPopup();
        } else {
          cucumberJuvenile = CucumberJuvenile.fromJson(response.data['data']);
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          Navigator.of(NavigationService.navigatorKey.currentContext!)
              .push(MaterialPageRoute(builder: (context) => const JuvenileCucumberDetails()));
        }

        notifyListeners();
      } catch (e) {
        Utils.showSnackBar('Something went wrong', NavigationService.navigatorKey.currentContext!);
      }
    }
  }

  Future<void> juvenileAdultPopup() {
    return showDialog<void>(
      context: NavigationService.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Wrap(
            children: [
              Container(
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
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: const Text(
                      'Speciman was identified as an Adult',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
