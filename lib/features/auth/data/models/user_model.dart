import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';
@JsonSerializable()
class UserModel {
  final String username;
  final String email;
  final String first_name;
  final String last_name;
  final String? dob;
  final String access;
  final String refresh;

  UserModel({
    required this.username,
    required this.email,
    required this.first_name,
    required this.last_name,
    this.dob,
    required this.access,
    required this.refresh,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
      dob: json['dob'],
      access: json['access'] ?? '',
      refresh: json['refresh'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      email: email,
      firstName: first_name,
      lastName: last_name,
      dob: dob,
      access: access,
      refresh: refresh,
    );
  }
}

