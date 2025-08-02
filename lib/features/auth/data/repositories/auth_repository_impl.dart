import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../../../../core/utils/secure_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorage storage;

  AuthRepositoryImpl(this.remoteDataSource, this.storage);

  @override
  Future<Either<Failures, UserEntity>> register(Map<String, dynamic> body) async {
    final result = await remoteDataSource.register(body);
    return result.fold(
          (failure) => Left(failure),
          (userModel) => Right(userModel as UserEntity),
    );
  }

  @override
  Future<Either<Failures, UserEntity>> login(Map<String, dynamic> body) async {
    final result = await remoteDataSource.login(body);

    if (result.isLeft()) {
      return Left(result.fold((l) => l, (r) => throw UnimplementedError()));
    }

    final user = result.getOrElse(() => throw Exception('No user'));

    if (user.access != null) {
      await storage.saveAccessToken(user.access!);
      print('✅ Access token saved: ${user.access}');
    }

    if (user.refresh != null) {
      await storage.saveRefreshToken(user.refresh!);
      print('🔁 Refresh token saved: ${user.refresh}');
    }

    print('🎉 Login success, user data: ${user.toString()}');
    return Right(user);
  }
}