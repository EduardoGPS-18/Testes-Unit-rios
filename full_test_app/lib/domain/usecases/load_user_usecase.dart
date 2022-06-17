import '../entities/entities.dart';

abstract class LoadUserUsecase {
  Future<UserEntity> call();
}
