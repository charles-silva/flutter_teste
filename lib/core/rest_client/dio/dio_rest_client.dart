// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_dev_test/core/rest_client/rest_client.dart';
import 'package:flutter_dev_test/core/rest_client/rest_client_response.dart';

import '../rest_client_exception.dart';

class DioRestClient implements RestClient {
  final baseUrl = 'http://127.0.0.1:5000';
  var _defaultOptions = BaseOptions();
  late Dio _dio;

  initOptions(String baseUrl) {
    _defaultOptions = BaseOptions(
      baseUrl: baseUrl,
    );
  }

  DioRestClient() {
    initOptions(baseUrl);
    _dio = Dio(_defaultOptions);
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      throw RestClientException(
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        error: e.error,
        response: _dioErrorConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      throw RestClientException(
        message: e.response?.statusMessage,
        statusCode: e.response?.statusCode,
        error: e.error,
        response: _dioErrorConverter(e.response),
      );
    }
  }

  RestClientResponse<T> _dioErrorConverter<T>(Response? response) {
    return RestClientResponse<T>(
      data: response?.data,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
    );
  }
}
