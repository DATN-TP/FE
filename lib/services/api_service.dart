import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(): baseUrl = dotenv.env['BASE_URL']?? '';
  Future<Map<String, dynamic>> _request(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final defaultHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    headers ??= {};
    headers.addAll(defaultHeaders);

    http.Response response;

    switch (method) {
      case 'POST':
        response = await http.post(
          uri,
          headers: headers,
          body: json.encode(body),
        );
        break;
      case 'PUT':
        response = await http.put(
          uri,
          headers: headers,
          body: json.encode(body),
        );
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: headers);
        break;
      case 'GET':
      default:
        response = await http.get(uri, headers: headers);
        break;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: response.reasonPhrase ?? 'Unknown error',
        body: response.body,
      );
    }
  }

  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? headers}) async {
    return _request('GET', endpoint, headers: headers);
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    return _request('POST', endpoint, body: body, headers: headers);
  }

  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body, {Map<String, String>? headers}) async {
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
