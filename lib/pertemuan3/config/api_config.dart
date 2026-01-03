class ApiConfig {
  static const String baseUrl =
      'https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate';

  static const String userEndpoint = '/user';

  static const String cityEndpoint = '/city';

  static String get userUrl => '$baseUrl$userEndpoint';

  static String get cityUrl => '$baseUrl$cityEndpoint';
}
