import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sea_cense/models/cucumber_all.dart';
import 'package:sea_cense/views/home/all_details.dart';
import 'package:share_plus/share_plus.dart';

import 'package:sea_cense/models/base_api_response.dart';
import 'package:sea_cense/models/cucumber_juvenile.dart';
import 'package:sea_cense/models/cucumber_live.dart';
import 'package:sea_cense/models/cucumber_price.dart';
import 'package:sea_cense/models/cucumber_processed.dart';
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
import 'package:sea_cense/views/home/price_details.dart';
import 'package:sea_cense/views/home/processed_cucmber_details.dart';
import 'package:sea_cense/widgets/common_button_widget.dart';

class CucumberViewModel extends ChangeNotifier {
  ScreenshotController screenshotController = ScreenshotController();
  final CucumberService service = CucumberService();
  CucumberLive? foundCucumberForLive;
  CucumberProcessed? cucumberProcessed;
  CucumberPrice? cucumberPrice;
  CucumberJuvenile? cucumberJuvenile;
  CucumberAll? cucumberAll;
  XFile? imageFile;
  bool isGen = false;
  bool isCamera = false;

  void setGen() {
    isGen = !isGen;
  }

  Future<void> addImage(BuildContext context, ProcessorType processorType) async {
    if (isCamera) {
      imageFile = await CameraHelper.takeImages();
    } else {
      imageFile = await CameraHelper.selectImages();
    }

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
              CommonButtonWidget(
                text: "Continue",
                size: MediaQuery.of(context).size.width / 1.3,
                onTap: () {
                  EasyLoading.instance
                    ..displayDuration = const Duration(milliseconds: 2000)
                    ..indicatorColor = Colors.white
                    ..maskColor = const Color(0xDA1B0130)
                    ..textColor = defaultColor
                    ..dismissOnTap = false;
                  EasyLoading.show(status: 'loading...');

                  switch (processorType) {
                    case ProcessorType.live:
                      liveProcess();
                      break;
                    case ProcessorType.processed:
                      processedProcess();
                      break;
                    case ProcessorType.price:
                      priceProcess();
                      break;
                    case ProcessorType.juvenile:
                      juvenileProcess();
                      break;
                    case ProcessorType.all:
                      allProcess();
                      break;
                    case ProcessorType.allAlt:
                      allAltProcess();
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

  void allProcess() async {
    Function(int, int)? onSendProgress;

    BaseAPIResponse response =
        await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getAllEndpoint());
    if (response.error) {
      EasyLoading.dismiss();
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
      Utils.showSnackBar(
          'Something went wrong -- ${response.status}', NavigationService.navigatorKey.currentContext!);
    } else {
      try {
        cucumberAll = CucumberAll(
          cucumberJuvenile: getAllJuvenile(response),
          cucumberLive: getAllLive(response),
          cucumberPrice: getAllPrice(response),
        );

        if (cucumberAll!.cucumberLive == "Unknown" && cucumberAll!.cucumberPrice == "Unknown") {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          dataPopup('Speciman was not recognized');
        } else {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);

          Navigator.of(NavigationService.navigatorKey.currentContext!)
              .push(MaterialPageRoute(builder: (context) => const AllDetails()));
        }
      } catch (e) {
        EasyLoading.dismiss();
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
        Utils.showSnackBar('Something went wrong -- $e', NavigationService.navigatorKey.currentContext!);
      }
    }
  }

  void allAltProcess() async {
    Function(int, int)? onSendProgress;

    BaseAPIResponse juvenileResponse =
        await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getJuvenileEndpoint());
    if (juvenileResponse.error) {
      EasyLoading.dismiss();
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
      Utils.showSnackBar('Something went wrong -- ${juvenileResponse.status}',
          NavigationService.navigatorKey.currentContext!);
    } else {
      try {
        BaseAPIResponse liveResponse =
            await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getLiveEndpoint());

        if (liveResponse.error) {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          Utils.showSnackBar('Something went wrong -- ${liveResponse.status}',
              NavigationService.navigatorKey.currentContext!);
        } else {
          BaseAPIResponse priceResponse =
              await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getPriceEndpoint());

          if (priceResponse.error) {
            EasyLoading.dismiss();
            Navigator.pop(NavigationService.navigatorKey.currentContext!);
            Utils.showSnackBar('Something went wrong -- ${priceResponse.status}',
                NavigationService.navigatorKey.currentContext!);
          } else {
            cucumberAll = CucumberAll(
              cucumberJuvenile: getAlllAltJuvenile(juvenileResponse),
              cucumberLive: getAlllAltLive(liveResponse),
              cucumberPrice: getAlllAltPrice(priceResponse),
            );

            if (cucumberAll!.cucumberLive == "Unknown" && cucumberAll!.cucumberPrice == "Unknown") {
              EasyLoading.dismiss();
              Navigator.pop(NavigationService.navigatorKey.currentContext!);
              dataPopup('Speciman was not recognized');
            } else {
              EasyLoading.dismiss();
              Navigator.pop(NavigationService.navigatorKey.currentContext!);

              Navigator.of(NavigationService.navigatorKey.currentContext!)
                  .push(MaterialPageRoute(builder: (context) => const AllDetails()));
            }
          }
        }
      } catch (e) {
        EasyLoading.dismiss();
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
        Utils.showSnackBar('Something went wrong -- $e', NavigationService.navigatorKey.currentContext!);
      }
    }
  }

  void liveProcess() async {
    Function(int, int)? onSendProgress;

    BaseAPIResponse response =
        await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getLiveEndpoint());
    if (response.error) {
      EasyLoading.dismiss();
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
      Utils.showSnackBar(
          'Something went wrong -- ${response.status}', NavigationService.navigatorKey.currentContext!);
    } else {
      try {
        foundCucumberForLive = seaCucumbers.firstWhere(
          (cucumber) => cucumber.type == response.data['data']['predicted_class'],
        );

        if (foundCucumberForLive!.type == "Unknown") {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          dataPopup('Speciman was not recognized');
        } else {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          Navigator.of(NavigationService.navigatorKey.currentContext!)
              .push(MaterialPageRoute(builder: (context) => const LiveCucumberDetails()));
        }
      } catch (e) {
        EasyLoading.dismiss();
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
        Utils.showSnackBar('Something went wrong', NavigationService.navigatorKey.currentContext!);
      }
    }
  }

  void processedProcess() async {
    Function(int, int)? onSendProgress;
    BaseAPIResponse response =
        await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getProcessedEndpoint());
    if (response.error) {
      EasyLoading.dismiss();
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
      Utils.showSnackBar('Something went wrong ', NavigationService.navigatorKey.currentContext!);
    } else {
      try {
        cucumberProcessed = CucumberProcessed.fromJson(response.data['data']);

        if (cucumberProcessed!.predictedType == "Unkown") {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          dataPopup('Speciman was not recognized');
        } else {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          Navigator.of(NavigationService.navigatorKey.currentContext!)
              .push(MaterialPageRoute(builder: (context) => const ProcessedCucumberDetails()));
        }
      } catch (e) {
        EasyLoading.dismiss();
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
        Utils.showSnackBar('Something went wrong', NavigationService.navigatorKey.currentContext!);
      }
    }
  }

  void priceProcess() async {
    Function(int, int)? onSendProgress;
    BaseAPIResponse response =
        await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getPriceEndpoint());
    if (response.error) {
      EasyLoading.dismiss();
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
      Utils.showSnackBar(
          'Something went wrong -- ${response.status}', NavigationService.navigatorKey.currentContext!);
    } else {
      try {
        if (response.data['data']['predicted_class'] == "Unknown") {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          dataPopup('Speciman was not recognized');
        } else {
          cucumberPrice = priceCatergories[response.data['data']['predicted_class']];

          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);

          Navigator.of(NavigationService.navigatorKey.currentContext!)
              .push(MaterialPageRoute(builder: (context) => const PriceDetails()));
        }
        notifyListeners();
      } catch (e) {
        EasyLoading.dismiss();
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
        Utils.showSnackBar('Something went wrong', NavigationService.navigatorKey.currentContext!);
      }
    }
  }

  void juvenileProcess() async {
    Function(int, int)? onSendProgress;
    BaseAPIResponse response =
        await service.uploadImage(imageFile!, onSendProgress, UrlConstants.getJuvenileEndpoint());
    if (response.error) {
      EasyLoading.dismiss();
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
      Utils.showSnackBar(
          'Something went wrong -- ${response.status}', NavigationService.navigatorKey.currentContext!);
    } else {
      try {
        if (response.data['data'] == "Unknown") {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          dataPopup('Speciman was not recognized');
        } else if (response.data['data'] == "Adult") {
          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          dataPopup('Speciman was identified as an Adult');
        } else {
          cucumberJuvenile = CucumberJuvenile.fromJson(response.data['data']);

          EasyLoading.dismiss();
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          Navigator.of(NavigationService.navigatorKey.currentContext!)
              .push(MaterialPageRoute(builder: (context) => const JuvenileCucumberDetails()));
        }
        notifyListeners();
      } catch (e) {
        EasyLoading.dismiss();
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
        Utils.showSnackBar('Something went wrong', NavigationService.navigatorKey.currentContext!);
      }
    }
  }

  Future<void> getSharableScreen(Widget reportBody, BuildContext context) async {
    screenshotController
        .captureFromLongWidget(
      InheritedTheme.captureAll(
        context,
        Material(
          child: reportBody,
        ),
      ),
      delay: const Duration(seconds: 1),
      context: context,
    )
        .then((image) async {
      Navigator.pop(context);
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/SeaSence Report ${DateTime.now()}.png';

      final File imageFile = File(filePath);
      await imageFile.writeAsBytes(image);
      debugPrint('Image saved to: $filePath');
      await Share.shareXFiles([XFile(filePath)]);
    });
  }

  Future<void> dataPopup(String text) {
    return showDialog<void>(
      context: NavigationService.navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          alignment: Alignment.center,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }

  getAllJuvenile(BaseAPIResponse response) {
    if (response.data['data']['age'] == "Unknown" || response.data['data']['age'] == "Adult") {
      return response.data['data']['age'];
    } else {
      return CucumberJuvenile.fromJson(response.data['data']['age']);
    }
  }

  getAllLive(BaseAPIResponse response) {
    if (response.data['data']['live-classifier']['predicted_class'] == "Unknown") {
      return response.data['data']['live-classifier']['predicted_class'];
    } else {
      return seaCucumbers.firstWhere(
        (cucumber) => cucumber.type == response.data['data']['live-classifier']['predicted_class'],
      );
    }
  }

  getAllPrice(BaseAPIResponse response) {
    if (response.data['data']['predicted_class'] == "Unknown" ||
        response.data['data']['predicted_class'] == null) {
      return "Unknown";
    } else {
      return priceCatergories[response.data['data']['predicted_class']];
    }
  }

  getAlllAltJuvenile(BaseAPIResponse response) {
    if (response.data['data'] == "Unknown" || response.data['data'] == "Adult") {
      return response.data['data'];
    } else {
      return CucumberJuvenile.fromJson(response.data['data']);
    }
  }

  getAlllAltLive(BaseAPIResponse response) {
    if (response.data['data']['predicted_class'] == "Unknown") {
      return response.data['data']['predicted_class'];
    } else {
      return seaCucumbers.firstWhere(
        (cucumber) => cucumber.type == response.data['data']['predicted_class'],
      );
    }
  }

  getAlllAltPrice(BaseAPIResponse response) {
    if (response.data['data']['predicted_class'] == "Unknown" ||
        response.data['data']['predicted_class'] == null) {
      return "Unknown";
    } else {
      return priceCatergories[response.data['data']['predicted_class']];
    }
  }
}
