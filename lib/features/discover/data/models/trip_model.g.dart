// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripModel _$TripModelFromJson(Map<String, dynamic> json) => TripModel(
  startingPlace: json['starting_place'] as String? ?? '',
  startingDate: json['starting_date'] as String? ?? '',
  arrivalPlace: json['arrival_place'] as String? ?? '',
  arrivalDate: json['arrival_date'] as String? ?? '',
  durationDays:
      json['duration_days'] == null
          ? 0
          : TripModel._nullableIntFromJson(json['duration_days']),
  image: json['image'] as String? ?? '',
  costPerPerson: TripModel._nullableDoubleFromJson(json['cost_per_person']),
  vacantPlaces: TripModel._nullableIntFromJson(json['vacant_places']),
  description: json['description'] as String?,
  itinerary: (json['itinerary'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$TripModelToJson(TripModel instance) => <String, dynamic>{
  'starting_place': instance.startingPlace,
  'starting_date': instance.startingDate,
  'arrival_place': instance.arrivalPlace,
  'arrival_date': instance.arrivalDate,
  'duration_days': instance.durationDays,
  'image': instance.image,
  'cost_per_person': instance.costPerPerson,
  'vacant_places': instance.vacantPlaces,
  'description': instance.description,
  'itinerary': instance.itinerary,
};
