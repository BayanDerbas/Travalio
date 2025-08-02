import 'package:equatable/equatable.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/entities/user_entity.dart';

class AuthState extends Equatable {
  final String username;
  final String email;
  final String password;
  final String fullName;
  final DateTime? birthDate;
  final String? token;
  final bool isSubmitting;
  final bool isSuccess;
  final bool? isLoginSuccess;
  final Failures? failure;
  final UserEntity? user;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  const AuthState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.fullName = '',
    this.birthDate,
    this.token,
    this.isSubmitting = false,
    this.isLoginSuccess,
    this.isSuccess = false,
    this.failure,
    this.user,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });

  AuthState copyWith({
    String? username,
    String? email,
    String? password,
    String? fullName,
    DateTime? birthDate,
    String? token,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isLoginSuccess,
    Failures? failure,
    UserEntity? user,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
  }) {
    return AuthState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      birthDate: birthDate ?? this.birthDate,
      token: token ?? this.token,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      failure: failure ?? this.failure,
      user: user ?? this.user,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }

  @override
  List<Object?> get props => [
    username,
    email,
    password,
    fullName,
    birthDate,
    token,
    isSubmitting,
    isSuccess,
    failure,
    user,
    obscurePassword,
    obscureConfirmPassword,
  ];
}
