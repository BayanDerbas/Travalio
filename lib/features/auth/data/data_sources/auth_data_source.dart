import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/networks/api_service.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failures, UserEntity>> register(Map<String, dynamic> body);
  Future<Either<Failures, UserEntity>> login(Map<String, dynamic> body);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<Failures, UserEntity>> register(Map<String, dynamic> body) async {
    try {
      final response = await apiService.register(body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      print("🔥 Dio Error: ${e.response?.data}");
      return Left(serverFailure.fromDioError(e));
    } catch (e, s) {
      print("🔥 Unexpected Error: $e");
      print("📌 Stack: $s");
      return Left(serverFailure("Unexpected error: $e"));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> login(Map<String, dynamic> body) async {
    try {
      final response = await apiService.login(body);
      return Right(response.toEntity());
    } on DioException catch (e) {
      print("🔥 Dio Error: ${e.response?.data}");
      return Left(serverFailure.fromDioError(e));
    } catch (e, s) {
      print("🔥 Unexpected Error: $e");
      print("📌 Stack: $s");
      return Left(serverFailure("Unexpected error: $e"));
    }
  }
}