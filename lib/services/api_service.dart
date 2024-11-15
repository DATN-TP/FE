import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASE_URL'] ?? '',
    contentType: 'application/json; charset=UTF-8',
  ));

  Future<dynamic> _request(
    String method,
    String endpoint, {
    dynamic body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response;
      
      var token = HiveProvider().getToken();

      // Combine default headers with provided headers
      final defaultHeaders = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      // If body is FormData, set Content-Type to multipart/form-data
      if (body is FormData) {
        defaultHeaders['Content-Type'] = 'multipart/form-data';
      }

      headers = {...defaultHeaders, ...?headers};

      // Configure Dio request options
      final options = Options(
        method: method,
        headers: headers,
      );

      switch (method) {
        case 'POST':
          response = await _dio.post(endpoint, data: body, options: options);
          break;
        case 'PUT':
          response = await _dio.put(endpoint, data: body, options: options);
          break;
        case 'DELETE':
          response = await _dio.delete(endpoint, options: options);
          break;
        case 'GET':
        default:
          response = await _dio.get(endpoint, queryParameters: queryParameters, options: options);
          break;
      }

      // Handle the response
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return response.data;
      } else {
        throw ApiException(
          statusCode: response.statusCode ?? 0,
          message: response.statusMessage ?? 'Unknown error',
          body: response.data.toString(),
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Unknown error',
        body: e.response?.data.toString() ?? '',
      );
    }
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) async {
    return _request('GET', endpoint, headers: headers, queryParameters: queryParameters);
  }

  Future<dynamic> post(String endpoint, dynamic body, {Map<String, String>? headers}) async {
    return _request('POST', endpoint, body: body, headers: headers);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    return _request('PUT', endpoint, body: body, headers: headers);
  }

  Future<void> delete(String endpoint, {Map<String, String>? headers}) async {
    await _request('DELETE', endpoint, headers: headers);
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final String body;

  ApiException({
    required this.statusCode,
    required this.message,
    this.body = '',
  });

  @override
  String toString() {
    return 'ApiException(statusCode: $statusCode, message: $message, body: $body)';
  }
}