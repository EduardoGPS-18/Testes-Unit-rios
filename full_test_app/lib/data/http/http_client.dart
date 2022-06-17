abstract class HttpClient {
  Future<T> request<T>({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? body,
  });
}

enum HttpMethod {
  get,
  put,
  post,
  patch,
  delete,
}
