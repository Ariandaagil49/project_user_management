// class ApiConfig {
//   static const String baseUrl =
//       'https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate';

//   static const String userEndpoint = '/user';

//   static const String cityEndpoint = '/city';

//   static String get userUrl => '$baseUrl$userEndpoint';

//   static String get cityUrl => '$baseUrl$cityEndpoint';
// }


// ============================================================================
// PERTEMUAN 3: API CONFIG - KONFIGURASI URL API
// ============================================================================
//
// Konfigurasi API dipisahkan ke file tersendiri agar:
// 1. Mudah diubah jika URL berubah
// 2. Tidak ada hardcoded URL di banyak tempat
// 3. Mudah switch environment (dev, staging, production)
//
// ============================================================================

/// Kelas untuk konfigurasi API
class ApiConfig {
  /// Base URL API
  static const String baseUrl =
      'https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate';

  /// Endpoint untuk User
  static const String userEndpoint = '/user';

  /// Endpoint untuk City
  static const String cityEndpoint = '/city';

  /// URL lengkap untuk User
  static String get userUrl => '$baseUrl$userEndpoint';

  /// URL lengkap untuk City
  static String get cityUrl => '$baseUrl$cityEndpoint';
}
