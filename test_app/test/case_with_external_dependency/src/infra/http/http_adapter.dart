import '../../data/http/http_client.dart';
import '../../data/http/http_errors.dart';

class HttpAdapter implements HttpClient {
  final dynamic toReturnData;
  HttpAdapter({required this.toReturnData});

  @override
  Future<T> request<T>({
    required String url,
    required HttpMethod method,
  }) async {
    // Efetuar a chamada pegar o body e fazer verficação!

    if (toReturnData is! T) {
      throw InvalidDataTypeException();
    } else {
      return toReturnData as T;
    }
  }
}
