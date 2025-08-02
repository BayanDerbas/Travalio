part of 'trips_bloc.dart';

abstract class TripsState {}

class TripsInitial extends TripsState {}

class TripsLoading extends TripsState {}

class TripsLoaded extends TripsState {
  final List<TripEntity> trips;
  TripsLoaded(this.trips);
}

class TripLoaded extends TripsState {
  final TripEntity trip;
  TripLoaded(this.trip);
}

class TripsError extends TripsState {
  final String message;
  TripsError(this.message);
}
