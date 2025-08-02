import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failures, UserEntity>> call(Map<String, dynamic> body) {
    return repository.register(body);
  }
}

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failures, UserEntity>> call(Map<String, dynamic> body) {
    return repository.login(body);
  }
}

