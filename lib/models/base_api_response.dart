class BaseAPIResponse {
  BaseAPIResponse({this.status, this.msg, this.data, required this.error});

  int? status;
  String? msg;
  dynamic data;
  bool error;
}
