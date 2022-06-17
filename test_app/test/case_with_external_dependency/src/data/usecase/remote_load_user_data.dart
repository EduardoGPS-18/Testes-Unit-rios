import '../../domain/errors.dart';
import '../http/http_client.dart';
import '../model/user_model.dart';

abstract class LoadUserDataUsecase {
  Future<UserModel> call();
}

class RemoteLoadUserData implements LoadUserDataUsecase {
  final HttpClient client;
  final String url;

  RemoteLoadUserData({
    required this.client,
    required this.url,
  });

  @override
  Future<UserModel> call() async {
    try {
      final result = await client.request<Map<String, dynamic>>(
        url: url,
        method: HttpMethod.get,
      );

      return UserModel.fromMap(result);
    } on Exception {
      throw UnexpectedException();
    }
  }
}
