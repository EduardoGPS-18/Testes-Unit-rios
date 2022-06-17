import '../../src/data/http/http_client.dart';

class MockHttpClient implements HttpClient {
  final dynamic mockedResult;
  MockHttpClient({required this.mockedResult});

  @override
  Future<T> request<T>({
    required String url,
    required HttpMethod method,
  }) async {
    return mockedResult;
  }
}

class MockHttpClientThwors implements HttpClient {
  final dynamic toThrow;
  MockHttpClientThwors({required this.toThrow});

  @override
  Future<T> request<T>({
    required String url,
    required HttpMethod method,
  }) async {
    throw toThrow;
  }
}
