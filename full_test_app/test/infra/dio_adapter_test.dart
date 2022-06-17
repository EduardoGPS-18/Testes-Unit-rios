import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:full_test_app/data/http/http.dart';
import 'package:full_test_app/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mocks.dart';

void main() {
  late DioAdapter sut;
  late DioMock dioMock;
  late Faker faker;
  late String url;

  setUp(() {
    faker = Faker();
    url = faker.internet.httpsUrl();
    dioMock = DioMock();
    sut = DioAdapter(dio: dioMock);
  });

  group('(Should call dio HTTP methods correctly) -> ', () {
    test('(GET) Should call DioMock.get with correct data', () async {
      dioMock.mockGetResult(url, 'any_result');

      await sut.request(url: url, method: HttpMethod.get);

      verify(() => dioMock.get(url)).called(1);
    });

    test('(POST) Should call DioGet.post with correct data', () async {
      dioMock.mockPostResult(url, 'any_result');
      final mockBody = {'any_key': 'any_value'};

      await sut.request(url: url, method: HttpMethod.post, body: mockBody);

      verify(() => dioMock.post(url, data: mockBody)).called(1);
    });

    test('(PUT) Should call DioGet.put with correct data', () async {
      dioMock.mockPutResult(url, 'any_result');
      final mockBody = {'any_key': 'any_value'};

      await sut.request(url: url, method: HttpMethod.put, body: mockBody);

      verify(() => dioMock.put(url, data: mockBody)).called(1);
    });

    test('(PATCH) Should call DioGet.patch with correct data', () async {
      dioMock.mockPatchResult(url, 'any_result');
      final mockBody = {'any_key': 'any_value'};

      await sut.request(url: url, method: HttpMethod.patch, body: mockBody);

      verify(() => dioMock.patch(url, data: mockBody)).called(1);
    });

    test('(DELETE) Should call DioGet.delete with correct data', () async {
      dioMock.mockDeleteResult(url, 'any_result');
      final mockBody = {'any_key': 'any_value'};

      await sut.request(url: url, method: HttpMethod.delete, body: mockBody);

      verify(() => dioMock.delete(url, data: mockBody)).called(1);
    });
  });

  group('Convert test cases', () {
    final data = {'any_key': 'any_value'};

    setUp(() {
      dioMock.mockGetResult(url, data);
    });

    test('Should return converted data on received exactly expected data type', () async {
      final result = await sut.request<Map<String, dynamic>>(url: url, method: HttpMethod.get);
      expect(result, data);
    });

    test('Should throws MissmatchReceivedType on missmatch expected type', () async {
      final future = sut.request<List>(url: url, method: HttpMethod.get);
      expect(future, throwsA(isA<MissmatchReceivedType>()));
    });
  });

  group('HTTP errors cases', () {
    void testConversionBeetweenErrorStatusCodeAndReturnType<EXPECT_RETURN_TYPE>(int statusCode) {
      dioMock.mockGetError(url: url, errorData: {'message': 'an error ocurred'}, statusCode: statusCode);

      final future = sut.request(url: url, method: HttpMethod.get);

      expect(future, throwsA(isA<EXPECT_RETURN_TYPE>()));
    }

    test('Should emits BadRequestError on status code 400', () {
      testConversionBeetweenErrorStatusCodeAndReturnType<BadRequestError>(400);
    });

    test('Should emits UnauthorizedError on status code 401', () {
      testConversionBeetweenErrorStatusCodeAndReturnType<UnauthorizedError>(401);
    });

    test('Should emits ForbiddenError on status code 403', () {
      testConversionBeetweenErrorStatusCodeAndReturnType<ForbiddenError>(403);
    });

    test('Should emits NotFoundError on status code 404', () {
      testConversionBeetweenErrorStatusCodeAndReturnType<NotFoundError>(404);
    });

    test('Should emits ServerError as default', () {
      for (int i in [500, 501, 502, 503, 504, 505]) {
        testConversionBeetweenErrorStatusCodeAndReturnType<ServerError>(i);
      }
    });
  });
}
