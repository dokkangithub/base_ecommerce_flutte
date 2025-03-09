import 'package:meta/meta.dart';
import '../../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String type,
    required String name,
    required String email,
    required String avatar,
    required String avatarOriginal,
    String? phone,
  }) : super(
    id: id,
    type: type,
    name: name,
    email: email,
    avatar: avatar,
    avatarOriginal: avatarOriginal,
    phone: phone,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      avatarOriginal: json['avatar_original'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'email': email,
      'avatar': avatar,
      'avatar_original': avatarOriginal,
      'phone': phone,
    };
  }
}