// lib/features/discover/domain/entities/trip_entity.dart
class TripEntity {
  final String startingPlace;
  final String startingDate;
  final String arrivalPlace;
  final String arrivalDate;
  final int durationDays;
  final String image;
  final double? costPerPerson;
  final int? vacantPlaces;
  final String? description;
  final Map<String, String>? itinerary;

  TripEntity({
    required this.startingPlace,
    required this.startingDate,
    required this.arrivalPlace,
    required this.arrivalDate,
    required this.durationDays,
    required this.image,
    this.costPerPerson,
    this.vacantPlaces,
    this.description,
    this.itinerary,
  });
}