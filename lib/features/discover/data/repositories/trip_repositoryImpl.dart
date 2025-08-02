import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/entities/trip_entity.dart';
import '../../domain/repositories/trip_repositories.dart';
import '../data_sources/trip_datasource.dart';

class TripRepositoryImpl implements TripRepository {
  final TripRemoteDataSource remoteDataSource;

  TripRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, List<TripEntity>>> getTrips({String? category}) async {
    final result = await remoteDataSource.getTrips(category: category);
    return result.fold(
          (failure) => Left(failure),
          (trips) => Right(trips),
    );
  }

  @override
  Future<Either<Failures, TripEntity>> getTripById(int id) async {
    return await remoteDataSource.getTripById(id);
  }
}