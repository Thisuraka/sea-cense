import 'package:image_picker/image_picker.dart';
import 'package:sea_cense/models/base_api_response.dart';
import 'package:sea_cense/network/network.dart';
import 'package:sea_cense/utils/enums/request_types.dart';
import 'package:sea_cense/utils/urls.dart';

class CucumberService {
  Future<BaseAPIResponse> uploadImage(XFile imageFile) async {
    Map<String, dynamic>? data = {};
    BaseAPIResponse response = await Network.request(
        method: RequestType.post, endpointPath: UrlConstants.getLiveEndpoint(), body: data);

    return response;
  }
}
