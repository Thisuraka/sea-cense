import 'package:sea_cense/models/base_api_response.dart';
import 'package:sea_cense/network/network.dart';
import 'package:sea_cense/utils/enums/request_types.dart';
import 'package:sea_cense/utils/urls.dart';

class LoginService {
  Future<BaseAPIResponse> signin(String username, String password) async {
    Map<String, dynamic>? data = {"account": username.trim(), "imgcode": "", "password": password.trim()};
    BaseAPIResponse response = await Network.request(
        method: RequestType.post, endpointPath: UrlConstants.getLoginEndpoint(), body: data);

    return response;
  }
}
