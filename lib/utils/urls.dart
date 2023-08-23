class UrlConstants {
  // static const String baseUrl = "https://file.io/";
  static const String baseUrl = "http://10.0.2.2:5000";

  static const String emptyUserIcon =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  static String getLiveEndpoint() {
    return "/type-identification";
  }

  static String getProcessedEndpoint() {
    return "/quality";
  }

  static String getPriceEndpoint() {
    return "/price-prediction";
  }

  static String getJuvenileEndpoint() {
    return "/age-prediction";
  }
}
