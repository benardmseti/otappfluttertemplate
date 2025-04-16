abstract class ApiConstants {
  // Endpoints prefix repeated in each request
  static const String apiversionPrefix = '/api/v1/agent';

  /// The base URL for the API.
  static String get baseUrl => '';

  /// Endpoints used in the API.
  ///
  /// Authentication
  static String get agentLogin => '$apiversionPrefix/login';
}
