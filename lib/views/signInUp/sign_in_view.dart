import 'package:flutter/material.dart';
import 'package:sea_cense/style.dart';
import 'package:sea_cense/widgets/common_button_widget.dart';
import 'package:sea_cense/widgets/header_widget.dart';
import 'package:sea_cense/widgets/rounded_textbox_widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordCntroller = TextEditingController();
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(
                text: "Welcome back",
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: const Text(
                  "Sign in",
                  style: topicStyle,
                ),
              ),
              RoundedTextboxWidget(
                controller: emailController,
                labelText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              RoundedTextboxWidget(
                controller: passwordCntroller,
                labelText: 'Password',
              ),
              const SizedBox(
                height: 20,
              ),
              CommonButtonWidget(
                text: "Sign in",
                size: MediaQuery.of(context).size.width / 1.3,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
