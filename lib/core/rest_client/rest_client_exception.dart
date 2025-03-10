import 'package:flutter_dev_test/core/rest_client/rest_client_response.dart';

class RestClientException implements Exception {
  String? message;
  int? statusCode;
  dynamic error;
  RestClientResponse? response;

  RestClientException({
    this.message,
    this.statusCode,
    required this.error,
    this.response,
  });

  @override
  String toString() {
    return 'RestClientException(message: $message, statusCode: $statusCode, error: $error, response: $response)';
  }
}
