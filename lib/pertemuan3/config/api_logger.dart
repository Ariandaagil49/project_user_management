import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiLogger {
  ApiLogger._();

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

  static void logResponse(http.Response response) {
    debugPrint('│ 📥 API RESPONSE');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint('│ Status Code: ${response.statusCode}');
    debugPrint('│ Body: ${response.body}');
    debugPrint('└─────────────────────────────────────────────────────────');
  }

  static void logError(dynamic error, [StackTrace? stackTrace]) {
    debugPrint('│ ❌ API ERROR');
    debugPrint('├─────────────────────────────────────────────────────────');
    debugPrint('│ Error: $error');
    if (stackTrace != null) {
      debugPrint('│ Stack Trace: $stackTrace');
    }
    debugPrint('└─────────────────────────────────────────────────────────');
  }

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
