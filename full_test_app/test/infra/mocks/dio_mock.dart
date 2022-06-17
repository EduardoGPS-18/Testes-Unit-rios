import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {
  When mockGetCall(String url) => when(() => get(url));
  void mockGetResult(String url, dynamic data, {int? statusCode}) => mockGetCall(url).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: url),
        data: data,
        statusCode: statusCode,
      ));
  void mockGetError({required String url, dynamic errorData, required int statusCode}) =>
      mockGetCall(url).thenThrow(DioError(
        requestOptions: RequestOptions(path: url),
        response: Response(
          data: errorData,
          statusCode: statusCode,
          requestOptions: RequestOptions(path: url),
        ),
      ));

  When mockPostCall(String url) => when(() => post(url, data: any(named: 'data')));
  void mockPostResult(String url, dynamic data, {int? statusCode}) => mockPostCall(url).thenAnswer(
        (_) async => Response(requestOptions: RequestOptions(path: url), data: data, statusCode: statusCode),
      );
  void mockPostError({required String url, dynamic errorData, required int statusCode}) =>
      mockPostCall(url).thenThrow(DioError(
        requestOptions: RequestOptions(path: url),
        response: Response(
          data: errorData,
          statusCode: statusCode,
          requestOptions: RequestOptions(path: url),
        ),
      ));

  When mockPatchCall(String url) => when(() => patch(url, data: any(named: 'data')));
  void mockPatchResult(String url, dynamic data, {int? statusCode}) => mockPatchCall(url).thenAnswer(
        (_) async => Response(requestOptions: RequestOptions(path: url), data: data, statusCode: statusCode),
      );
  void mockPatchError({required String url, dynamic errorData, required int statusCode}) =>
      mockPatchCall(url).thenThrow(DioError(
        requestOptions: RequestOptions(path: url),
        response: Response(
          data: errorData,
          statusCode: statusCode,
          requestOptions: RequestOptions(path: url),
        ),
      ));

  When mockPutCall(String url) => when(() => put(url, data: any(named: 'data')));
  void mockPutResult(String url, dynamic data, {int? statusCode}) => mockPutCall(url).thenAnswer(
        (_) async => Response(requestOptions: RequestOptions(path: url), data: data, statusCode: statusCode),
      );
  void mockPutError({required String url, dynamic errorData, required int statusCode}) =>
      mockPutCall(url).thenThrow(DioError(
        requestOptions: RequestOptions(path: url),
        response: Response(
          data: errorData,
          statusCode: statusCode,
          requestOptions: RequestOptions(path: url),
        ),
      ));

  When mockDeleteCall(String url) => when(() => delete(url, data: any(named: 'data')));
  void mockDeleteResult(String url, dynamic data, {int? statusCode}) => mockDeleteCall(url).thenAnswer(
        (_) async => Response(requestOptions: RequestOptions(path: url), data: data, statusCode: statusCode),
      );
  void mockDeleteError({required String url, dynamic errorData, required int statusCode}) =>
      mockDeleteCall(url).thenThrow(DioError(
        requestOptions: RequestOptions(path: url),
        response: Response(
          data: errorData,
          statusCode: statusCode,
          requestOptions: RequestOptions(path: url),
        ),
      ));
}
