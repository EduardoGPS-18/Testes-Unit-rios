abstract class HttpClient {
  Future<T> request<T>({required String url, required HttpMethod method});
}

enum HttpMethod { get }
