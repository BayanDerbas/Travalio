import 'package:json_annotation/json_annotation.dart';
import 'package:travalio/features/auth/data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String access;
  final String refresh;

  LoginResponse({
    required this.access,
    required this.refresh,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  UserEntity toEntity() => UserEntity(
    username: "",
    email: "",
    firstName: "",
    lastName: "",
    dob: null,
    access: access,
    refresh: refresh,
  );
}
