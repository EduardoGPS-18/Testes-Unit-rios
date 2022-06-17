// Outros casos faltantes, verificar a chamada correta do dio
// Verificar possiveis erros do dio

import '../../src/data/http/http_client.dart';
import '../../src/data/http/http_errors.dart';
import '../../src/infra/http/http_adapter.dart';
import '../helpers.dart';

void testInvalidTypeConvert() async {
  final systemUnderTest =
      HttpAdapter(toReturnData: <String, dynamic>{'any_key': 'any_value'});

  try {
    await systemUnderTest.request<List>(url: 'any_url', method: HttpMethod.get);
  } catch (err) {
    expect(err.runtimeType, InvalidDataTypeException);
  }
}

void testValidTypeConvert() async {
  final toReturnData = <String, dynamic>{'any_key': 'any_value'};

  final systemUnderTest = HttpAdapter(toReturnData: toReturnData);

  final result = await systemUnderTest.request<Map<String, dynamic>>(
    url: 'any_url',
    method: HttpMethod.get,
  );

  expect(result, toReturnData);
}

void main() {
  testInvalidTypeConvert();
  testValidTypeConvert();
}
