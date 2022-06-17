import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:full_test_app/data/data.dart';
import 'package:full_test_app/data/http/http_client.dart';
import 'package:full_test_app/data/http/http_error.dart';
import 'package:full_test_app/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late RemoteLoadUser sut;
  late HttpClientMock clientMock;
  late Faker faker;
  late String url;
  late String id, name, phoneNumber;

  setUpAll(() {
    registerFallbackValue(HttpMethod.patch);
  });

  setUp(() {
    faker = Faker();
    clientMock = HttpClientMock();

    url = faker.internet.httpsUrl();
    sut = RemoteLoadUser(client: clientMock, url: url);

    id = faker.guid.guid();
    name = faker.person.name();
    phoneNumber = faker.phoneNumber.us();

    clientMock.mockRequestResult<Map<String, dynamic>>({'id': id, 'name': name, 'phoneNumber': phoneNumber});
  });

  test('Should return user on succeed', () async {
    final user = await sut.call();

    expect(user, UserEntity(id: id, name: name, phoneNumber: phoneNumber));
  });

  group('Client mock cases', () {
    test('Should call client with correct values', () async {
      await sut.call();

      verify(() => clientMock.request<Map<String, dynamic>>(url: url, method: HttpMethod.get)).called(1);
    });

    test('Should throw AccessDeniedError on UnauthorizedError', () async {
      clientMock.mockRequestThrows<Map<String, dynamic>>(UnauthorizedError(message: 'any_message'));

      final future = sut.call();

      expect(future, throwsA(isA<AccessDeniedError>()));
    });

    test('Should throw AccessDeniedError on ForbiddenError', () async {
      clientMock.mockRequestThrows<Map<String, dynamic>>(ForbiddenError(message: 'any_message'));

      final future = sut.call();

      expect(future, throwsA(isA<AccessDeniedError>()));
    });

    test('Should throw NotFoundError on NoDataError', () async {
      clientMock.mockRequestThrows<Map<String, dynamic>>(NotFoundError(message: 'any_message'));

      final future = sut.call();

      expect(future, throwsA(isA<NoDataError>()));
    });

    test('Should throws UnexpectedError on ServerError', () async {
      clientMock.mockRequestThrows<Map<String, dynamic>>(ServerError(message: 'any_message'));

      final future = sut.call();

      expect(future, throwsA(isA<UnexpectedError>()));
    });

    test('Should throws InvalidDataError on BadRequestError', () async {
      clientMock.mockRequestThrows<Map<String, dynamic>>(BadRequestError(message: 'any_message'));

      final future = sut.call();

      expect(future, throwsA(isA<InvalidDataError>()));
    });
  });

  group('Conversion cases', () {
    test('Should throw UnexpectedError on UnMatchObjectError', () {
      clientMock.mockRequestResult<Map<String, dynamic>>({'name': name, 'phoneNumber': phoneNumber});

      final future = sut.call();

      expect(future, throwsA(isA<UnexpectedError>()));
    });
  });
}
