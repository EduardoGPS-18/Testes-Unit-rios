import 'package:full_test_app/data/http/http.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements HttpClient {
  When mockRequestCall<T>() => when(() => request<T>(url: any(named: 'url'), method: any(named: 'method')));

  void mockRequestResult<T>(T data) => mockRequestCall<T>().thenAnswer((_) async => data);

  void mockRequestThrows<T>(dynamic exception) => mockRequestCall<T>().thenThrow(exception);
}
