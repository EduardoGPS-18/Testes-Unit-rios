import 'errors.dart';

class UserModel {
  String name;
  String id;

  UserModel({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('id')) {
      throw MissingDataException();
    }
    return UserModel(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }
}
