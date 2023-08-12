import 'package:dio/dio.dart';
import 'package:sea_cense/models/base_api_response.dart';
import 'package:sea_cense/utils/enums/request_types.dart';
import 'package:sea_cense/utils/storage.dart';
import 'package:sea_cense/utils/urls.dart';

class Network {
  static Future<BaseAPIResponse> request(
      {required RequestType method,
      required String endpointPath,
      Map<String, dynamic>? body,
      bool isFormData = false,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParams}) async {
    //Var init
    final dio = Dio();
    Response? response;
    String? token = await SharedPreference.getAccessToken();

    Map<String, dynamic> clientHeaders = {'authorization': 'Bearer $token'};

    if (headers != null) {
      clientHeaders = {'authorization': 'Bearer $token', ...headers};
    }

    // print('Token in client $endpointPath $token');

    //Request types
    try {
      switch (method) {
        case RequestType.get:
          response = await dio.get('${UrlConstants.baseUrl}$endpointPath',
              queryParameters: queryParams, options: Options(headers: clientHeaders));
          break;
        case RequestType.post:
          response = response = await dio.post('${UrlConstants.baseUrl}$endpointPath',
              options: Options(headers: clientHeaders),
              data: isFormData ? FormData.fromMap(body ?? {}) : body);
          break;
        case RequestType.put:
          response = response = await dio.put('${UrlConstants.baseUrl}$endpointPath',
              options: Options(headers: clientHeaders),
              data: isFormData ? FormData.fromMap(body ?? {}) : body);
          break;
        case RequestType.patch:
          break;
        case RequestType.delete:
          response = response = await dio.delete('${UrlConstants.baseUrl}$endpointPath',
              options: Options(headers: clientHeaders),
              data: isFormData ? FormData.fromMap(body ?? {}) : body);
          break;
      }

      if (response!.statusCode == 200 && response.data["status"] == 200) {
        var jsonbody = response.data;

        return BaseAPIResponse(
            data: jsonbody["data"], error: false, msg: jsonbody["msg"], status: jsonbody["status"]);
      } else {
        var jsonbody = response.data;
        return BaseAPIResponse(data: null, error: true, msg: jsonbody["msg"], status: jsonbody["status"]);
      }
    } on DioError catch (e) {
      return BaseAPIResponse(data: null, error: true, msg: e.message, status: e.response!.statusCode);
    }
  }

  static Future<BaseAPIResponse> upload(
      {required String filePath,
      required String fileName,
      required String endpoint,
      required Function(int, int)? onSendProgress}) async {
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    });

    String? token = await SharedPreference.getAccessToken();

    Dio dio = Dio();

    try {
      var response = await dio.post(
        '${UrlConstants.baseUrl}$endpoint',
        data: data,
        options: Options(
          headers: {'authorization': 'Bearer $token'},
        ),
        onSendProgress: onSendProgress,
      );

      return BaseAPIResponse(
          data: {'url': response.data['data']['url'], 'name': response.data['data']['name']},
          error: false,
          msg: response.statusMessage,
          status: response.statusCode);
    } on DioError catch (e) {
      return BaseAPIResponse(data: null, error: true, msg: e.message, status: e.response?.statusCode);
    }
  }
}
