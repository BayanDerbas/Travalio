import 'package:travalio/features/auth/data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';

class RegisterResponse {
  final String message;
  final UserModel data;

  RegisterResponse({
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    message: json['message'],
    data: UserModel.fromJson(json['data']),
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data.toJson(),
  };

  UserEntity toEntity() => data.toEntity();
}
