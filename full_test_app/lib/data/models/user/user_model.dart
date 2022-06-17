import '../../../domain/domain.dart';
import '../errors/errors.dart';

extension UserModel on UserEntity {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  static UserEntity fromMap(Map<String, dynamic> map) {
    try {
      return UserEntity(
        id: map['id'],
        name: map['name'],
        phoneNumber: map['phoneNumber'],
      );
    } on TypeError {
      throw UnMatchObjectError();
    }
  }
}
