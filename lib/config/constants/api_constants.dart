class EnvironmentVariables {
  EnvironmentVariables._();
  // Base url
  static String get baseUrl => "https://api.slingacademy.com";
  // Get product
  static String get getProduct => "$baseUrl/v1/sample-data/products/?&limit=30";
}
