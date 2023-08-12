import 'package:flutter/material.dart';
import 'package:sea_cense/service/login_service.dart';

class SignInUpViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordCntroller = TextEditingController();
  final TextEditingController confPasswordCntroller = TextEditingController();

  final LoginService service = LoginService();

  void init() {}

  void signin({required VoidCallback onSuccess}) async {
    // loginBtnText = 'customerService.loading';
    // notifyListeners();
    // BaseAPIResponse response =
    //     await service.signin(username.text, password.text);
    // if (response.error) {
    //   loginBtnText = 'customerService.login';
    //   notifyListeners();
    // } else {
    //   // print('Token from sign in ${response.data['token']}');
    //   User.fromJson(response.data["kefuInfo"]);
    //   await SharedPreference.setAccessToken(response.data['token']);

    //   WebSocket().connect(response.data['token']);

    //   String message = jsonEncode({
    //     "data": {"id": await SharedPreference.getUserId()},
    //     "type": "to_chat"
    //   });
    //   WebSocket().send(message);
    //   loginBtnText = 'customerService.login';
    //   notifyListeners();
    //   onSuccess();
    // }
  }

  void signup({required VoidCallback onSuccess}) async {}

  disposeControllers() {
    emailController.dispose();
    passwordCntroller.dispose();
    confPasswordCntroller.dispose();
  }
}
