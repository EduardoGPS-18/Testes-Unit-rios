import '../../src/data/http/http_errors.dart';
import '../../src/data/usecase/remote_load_user_data.dart';
import '../../src/domain/errors.dart';
import '../helpers.dart';
import 'mock_http_client.dart';

// Adicionar teste de chamada correta de dependencias externas (HTTP CLIENT)

Future<void> testShouldThrwosIfHttpClientThrows() async {
  final mockedHttp = MockHttpClientThwors(toThrow: InvalidDataTypeException());
  final systemUnderTest = RemoteLoadUserData(client: mockedHttp, url: 'any_url');

  try {
    await systemUnderTest.call();
  } catch (err) {
    expect(err.runtimeType, UnexpectedException);
  }
}

Future<void> testShouldThrowsIfUserModelThrows() async {
  final mockedHttp = MockHttpClient(mockedResult: {'name': 'any_name'});
  final systemUnderTest = RemoteLoadUserData(client: mockedHttp, url: 'any_url');

  try {
    await systemUnderTest.call();
  } catch (err) {
    expect(err.runtimeType, UnexpectedException);
  }
}

Future<void> shouldReturnUserModelOnSuccess() async {
  final mockedHttp = MockHttpClient(mockedResult: {
    'name': 'Carlos Santana', // Mockado, porém, podemos usar o faker
    'id': 'd65bccdd-0e26-4719-895f-64d15b85b70f' // ^^
  });
  final systemUnderTest = RemoteLoadUserData(client: mockedHttp, url: 'any_url');
  final user = await systemUnderTest.call();

  expect(user.name, 'Carlos Santana');
  expect(user.id, 'd65bccdd-0e26-4719-895f-64d15b85b70f');
}

void main() {
  // Success Cases
  shouldReturnUserModelOnSuccess();

  // Errors Cases
  testShouldThrowsIfUserModelThrows();
  testShouldThrwosIfHttpClientThrows();
}
