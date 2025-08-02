import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failures, UserEntity>> register(Map<String, dynamic> body);
  Future<Either<Failures, UserEntity>> login(Map<String, dynamic> body);
}