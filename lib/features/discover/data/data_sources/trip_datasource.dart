import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/networks/api_service.dart';
import '../../../../core/networks/failures.dart';
import '../models/trip_model.dart';

abstract class TripRemoteDataSource {
  Future<Either<Failures, List<TripModel>>> getTrips({String? category});
  Future<Either<Failures, TripModel>> getTripById(int id);
}

class TripRemoteDataSourceImpl implements TripRemoteDataSource {
  final ApiService apiService;

  TripRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<Failures, List<TripModel>>> getTrips({String? category}) async {
    try {
      final response = await apiService.getTrips(category: category);
      log('API Response: ${response.toJson()}');
      return Right(response.results);
    } catch (e) {
      if (e is DioException) {
        log('Dio Error: ${e.message}');
        return Left(serverFailure.fromDioError(e));
      }
      log('Error: $e');
      return Left(serverFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failures, TripModel>> getTripById(int id) async {
    try {
      final response = await apiService.getTripById(id);
      log('API Response for trip $id: ${response.toJson()}');
      return Right(response);
    } catch (e) {
      if (e is DioException) {
        log('Dio Error for trip $id: ${e.message}');
        return Left(serverFailure.fromDioError(e));
      }
      log('Error fetching trip $id: $e');
      return Left(serverFailure(e.toString()));
    }
  }
}