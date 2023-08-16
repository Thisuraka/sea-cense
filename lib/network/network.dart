import 'package:dio/dio.dart';
import 'package:sea_cense/models/base_api_response.dart';
import 'package:sea_cense/utils/enums/request_types.dart';
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

    //Request types
    try {
      switch (method) {
        case RequestType.get:
          response = await dio.get('${UrlConstants.baseUrl}$endpointPath',
              queryParameters: queryParams, options: Options());
          break;
        case RequestType.post:
          response = await dio.post('${UrlConstants.baseUrl}$endpointPath',
              options: Options(), data: isFormData ? FormData.fromMap(body ?? {}) : body);

          break;
        case RequestType.put:
          response = await dio.put('${UrlConstants.baseUrl}$endpointPath',
              options: Options(), data: isFormData ? FormData.fromMap(body ?? {}) : body);
          break;
        case RequestType.patch:
          break;
        case RequestType.delete:
          response = await dio.delete('${UrlConstants.baseUrl}$endpointPath',
              options: Options(), data: isFormData ? FormData.fromMap(body ?? {}) : body);
          break;
      }

      if (response!.statusCode == 200 && response.data["status_code"] == 200) {
        var jsonbody = response.data;

        return BaseAPIResponse(data: jsonbody["data"], error: false, status: jsonbody["status_code"]);
      } else {
        var jsonbody = response.data;

        return BaseAPIResponse(data: null, error: true, status: jsonbody["status_code"]);
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      return BaseAPIResponse(data: null, error: true, status: e.response!.statusCode);
    }
  }

  static Future<BaseAPIResponse> upload(
      {required String filePath,
      required String fileName,
      required String endpoint,
      required Function(int, int)? onSendProgress}) async {
    FormData data = FormData.fromMap({
      "image_path": await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    });

    Dio dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 20);

    try {
      var response = await dio.post(
        '${UrlConstants.baseUrl}$endpoint',
        data: data,
        // options: Options(),
        onSendProgress: onSendProgress,
      );

      return BaseAPIResponse(data: response.data, error: false, status: response.statusCode);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      return BaseAPIResponse(data: null, error: true, status: e.response?.statusCode);
    }
  }
}
