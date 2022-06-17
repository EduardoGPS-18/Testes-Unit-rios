import '../../domain/domain.dart';
import '../http/http.dart';
import '../models/models.dart';

class RemoteLoadUser implements LoadUserUsecase {
  final HttpClient client;
  final String url;

  RemoteLoadUser({
    required this.client,
    required this.url,
  });

  @override
  Future<UserEntity> call() async {
    try {
      final map = await client.request<Map<String, dynamic>>(url: url, method: HttpMethod.get);
      return UserModel.fromMap(map);
    } on HttpError catch (err) {
      throw err.toDomainError();
    } on ModelError catch (err) {
      throw err.toDomainError();
    }
  }
}
