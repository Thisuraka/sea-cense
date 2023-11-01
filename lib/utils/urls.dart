class UrlConstants {
  // static const String environment = "development";
  static const String environment = "production";
  static const String baseUrl = "http://10.0.2.2:8080";
  // static const String baseUrl = "http://192.168.1.4:8080";

  static String getLiveEndpoint() {
    if (environment == "development") {
      return "$baseUrl/type-identification";
    } else {
      return "https://identifytype-b4m2z2hufa-as.a.run.app/type-identification";
    }
  }

  static String getProcessedEndpoint() {
    if (environment == "development") {
      return "$baseUrl/quality";
    } else {
      return "https://qualityprediction-b4m2z2hufa-as.a.run.app/quality";
    }
  }

  static String getPriceEndpoint() {
    if (environment == "development") {
      return "$baseUrl/price-prediction";
    } else {
      return "https://predictprice-b4m2z2hufa-as.a.run.app/price-prediction";
    }
  }

  static String getJuvenileEndpoint() {
    if (environment == "development") {
      return "$baseUrl/age-prediction";
    } else {
      return "https://predictage-b4m2z2hufa-as.a.run.app/age-prediction";
    }
  }

  static String getAllEndpoint() {
    if (environment == "development") {
      return "$baseUrl/all";
    } else {
      return "https://all-b4m2z2hufa-uc.a.run.app/all";
    }
  }
}
