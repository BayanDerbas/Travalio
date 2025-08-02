import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/trip_entity.dart';

abstract class TripRepository {
  Future<Either<Failures, List<TripEntity>>> getTrips({String? category});
  Future<Either<Failures, TripEntity>> getTripById(int id);
}