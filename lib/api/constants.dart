class ApiConstants {
  // Endpoints prefix repeated in each request
  static const String apiPrefix = '/api/v1/agent';

  /// The base URL for the API.
  static String get baseUrl => '';

  /// Endpoints used in the API.
  ///
  /// Authentication
  static String get agentLogin => '$apiPrefix/login';
}
