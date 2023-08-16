class BaseAPIResponse {
  BaseAPIResponse({this.status, this.data, required this.error});

  int? status;
  dynamic data;
  bool error;
}
