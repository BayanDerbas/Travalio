part of 'trips_bloc.dart';

abstract class TripsEvent {
  const TripsEvent();
}

class FetchTrips extends TripsEvent {
  final String? category;
  const FetchTrips({this.category});
}

class FetchTripById extends TripsEvent {
  final int id;
  const FetchTripById(this.id);
}