import 'dart:async';

import 'package:dio/dio.dart';
import 'package:full_test_app/data/http/http.dart';

class DioAdapter implements HttpClient {
  final Dio dio;

  DioAdapter({
    required this.dio,
  });

  @override
  Future<T> request<T>({required String url, required HttpMethod method, Map<String, dynamic>? body}) async {
    try {
      final Future<Response> toMakeHttpCall;

      switch (method) {
        case HttpMethod.get:
          toMakeHttpCall = dio.get(url);
          break;
        case HttpMethod.put:
          toMakeHttpCall = dio.put(url, data: body);
          break;
        case HttpMethod.post:
          toMakeHttpCall = dio.post(url, data: body);
          break;
        case HttpMethod.patch:
          toMakeHttpCall = dio.patch(url, data: body);
          break;
        case HttpMethod.delete:
          toMakeHttpCall = dio.delete(url, data: body);
          break;
      }

      final result = await toMakeHttpCall;
      return (await result.data) as T;
    } on DioError catch (err) {
      final responseCode = err.response?.statusCode;
      final errorMessage = err.response?.data?['message'] ?? '';
      switch (responseCode) {
        case 400:
          throw BadRequestError(message: errorMessage);
        case 401:
          throw UnauthorizedError(message: errorMessage);
        case 403:
          throw ForbiddenError(message: errorMessage);
        case 404:
          throw NotFoundError(message: errorMessage);
        default:
          throw ServerError(message: errorMessage);
      }
    } on TypeError {
      throw MissmatchReceivedType();
    }
  }
}
