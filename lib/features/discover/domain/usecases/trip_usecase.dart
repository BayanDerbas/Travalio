import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../entities/trip_entity.dart';
import '../repositories/trip_repositories.dart';

class GetTripsUseCase {
  final TripRepository repository;

  GetTripsUseCase(this.repository);

  Future<Either<Failures, List<TripEntity>>> call({String? category}) async {
    return await repository.getTrips(category: category);
  }
}

class GetTripByIdUseCase {
  final TripRepository repository;

  GetTripByIdUseCase(this.repository);

  Future<Either<Failures, TripEntity>> call({required int id}) async {
    return await repository.getTripById(id);
  }
}