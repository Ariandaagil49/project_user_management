// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// class ApiLogger {
//   ApiLogger._();

//   static void logRequest({
//     required String method,
//     required String url,
//     dynamic body,
//   }) {
//     debugPrint('┌─────────────────────────────────────────────────────────');
//     debugPrint('│ 🌐 API REQUEST');
//     debugPrint('├─────────────────────────────────────────────────────────');
//     debugPrint('│ Method: $method');
//     debugPrint('│ URL: $url');
//     if (body != null) {
//       debugPrint('│ Body: $body');
//     }
//     debugPrint('├─────────────────────────────────────────────────────────');
//   }

//   static void logResponse(http.Response response) {
//     debugPrint('│ 📥 API RESPONSE');
//     debugPrint('├─────────────────────────────────────────────────────────');
//     debugPrint('│ Status Code: ${response.statusCode}');
//     debugPrint('│ Body: ${response.body}');
//     debugPrint('└─────────────────────────────────────────────────────────');
//   }

//   static void logError(dynamic error, [StackTrace? stackTrace]) {
//     debugPrint('│ ❌ API ERROR');
//     debugPrint('├─────────────────────────────────────────────────────────');
//     debugPrint('│ Error: $error');
//     if (stackTrace != null) {
//       debugPrint('│ Stack Trace: $stackTrace');
//     }
//     debugPrint('└─────────────────────────────────────────────────────────');
//   }

//   static void logComplete({
//     required String method,
//     required String url,
//     required http.Response response,
//     dynamic requestBody,
//   }) {
//     logRequest(method: method, url: url, body: requestBody);
//     logResponse(response);
//   }
// }



// ============================================================================
// PERTEMUAN 3: API LOGGER UTILITY
// ============================================================================
//
// 🆕 FILE BARU DI PERTEMUAN 3!
// ============================================================================
//
// Di Pertemuan 1 & 2, kita menggunakan debugPrint langsung di setiap
// pemanggilan API. Ini menyebabkan:
// - Kode yang berulang-ulang (tidak DRY - Don't Repeat Yourself)
// - Format logging yang tidak konsisten
// - Sulit untuk mengubah format logging di seluruh aplikasi
//
// Di Pertemuan 3, kita membuat UTILITY CLASS untuk logging:
// - Satu tempat untuk semua logic logging
// - Format konsisten di seluruh aplikasi
// - Mudah diubah atau di-upgrade (misal: ke PrettyDioLogger)
//
// CATATAN:
// Ini adalah versi sederhana menggunakan debugPrint.
// Di production, bisa menggunakan:
// - PrettyDioLogger (untuk Dio)
// - Logger package
// - Firebase Crashlytics untuk error logging
//
// ============================================================================

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Utility class untuk logging API request dan response
///
/// Class ini menyediakan method statis untuk logging yang konsisten
/// di seluruh aplikasi.
class ApiLogger {
  // Private constructor - class ini tidak perlu di-instantiate
  ApiLogger._();

  // -------------------------------------------------------------------------
  // LOG REQUEST
  // -------------------------------------------------------------------------

  /// Log HTTP request sebelum dikirim
  ///
  /// Parameter:
  /// - [method]: HTTP method (GET, POST, PUT, DELETE)
  /// - [url]: URL endpoint yang dipanggil
  /// - [body]: Request body (optional, untuk POST/PUT)
  static void logRequest({
    required String method,
    required String url,
    dynamic body,
  }) {
    debugPrint('┌─────────────────────────────────────────────────────────');
    debugPrint('│ 🌐 API REQUEST');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint('│ Method: $method');
    debugPrint('│ URL: $url');
    if (body != null) {
      debugPrint('│ Body: $body');
    }
    debugPrint('├─────────────────────────────────────────────────────────');
  }

  // -------------------------------------------------------------------------
  // LOG RESPONSE
  // -------------------------------------------------------------------------

  /// Log HTTP response setelah diterima
  ///
  /// Parameter:
  /// - [response]: HTTP Response object dari package http
  static void logResponse(http.Response response) {
    debugPrint('│ 📥 API RESPONSE');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint('│ Status Code: ${response.statusCode}');
    debugPrint('│ Body: ${response.body}');
    debugPrint('└─────────────────────────────────────────────────────────');
  }

  // -------------------------------------------------------------------------
  // LOG ERROR
  // -------------------------------------------------------------------------

  /// Log error yang terjadi saat API call
  ///
  /// Parameter:
  /// - [error]: Error yang terjadi
  /// - [stackTrace]: Stack trace untuk debugging (optional)
  static void logError(dynamic error, [StackTrace? stackTrace]) {
    debugPrint('│ ❌ API ERROR');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint('│ Error: $error');
    if (stackTrace != null) {
      debugPrint('│ Stack Trace: $stackTrace');
    }
    debugPrint('└─────────────────────────────────────────────────────────');
  }

  // -------------------------------------------------------------------------
  // LOG COMPLETE (ALL-IN-ONE)
  // -------------------------------------------------------------------------

  /// Log request dan response dalam satu panggilan
  ///
  /// Method ini untuk kemudahan - memanggil logRequest dan logResponse
  /// dalam satu method.
  ///
  /// Parameter:
  /// - [method]: HTTP method (GET, POST, PUT, DELETE)
  /// - [url]: URL endpoint yang dipanggil
  /// - [response]: HTTP Response object
  /// - [requestBody]: Request body (optional, untuk POST/PUT)
  static void logComplete({
    required String method,
    required String url,
    required http.Response response,
    dynamic requestBody,
  }) {
    logRequest(method: method, url: url, body: requestBody);
    logResponse(response);
  }
}
