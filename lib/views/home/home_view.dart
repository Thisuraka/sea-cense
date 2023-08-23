import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sea_cense/style.dart';
import 'package:sea_cense/utils/enums/processor_type.dart';
import 'package:sea_cense/viewmodels/cucumber_viewmodel.dart';
import 'package:sea_cense/views/onboarding/onboarding.dart';
import 'package:sea_cense/widgets/home_tile_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                      onTap: () {
                        model.addImage(context, ProcessorType.price);
                      },
                    ),
                    HomeTileWidget(
                      icon: Icons.new_label,
                      title: 'Juvenile',
                      onTap: () {
                        model.addImage(context, ProcessorType.juvenile);
                      },
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => const OnboardingView()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: const Color(0xFFBE2929),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Color(0xFFBE2929),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
