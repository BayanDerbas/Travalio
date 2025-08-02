// lib/features/discover/data/models/trip_model.dart
import 'package:json_annotation/json_annotation.dart';
import 'dart:developer';
import '../../domain/entities/trip_entity.dart';

part 'trip_model.g.dart';

@JsonSerializable()
class TripModel extends TripEntity {
  @JsonKey(name: 'starting_place', defaultValue: '')
  final String startingPlace;

  @JsonKey(name: 'starting_date', defaultValue: '')
  final String startingDate;

  @JsonKey(name: 'arrival_place', defaultValue: '')
  final String arrivalPlace;

  @JsonKey(name: 'arrival_date', defaultValue: '')
  final String arrivalDate;

  @JsonKey(name: 'duration_days', fromJson: _nullableIntFromJson, defaultValue: 0)
  final int durationDays;

  @JsonKey(name: 'image', defaultValue: '')
  final String image;

  @JsonKey(name: 'cost_per_person', fromJson: _nullableDoubleFromJson)
  final double? costPerPerson;

  @JsonKey(name: 'vacant_places', fromJson: _nullableIntFromJson)
  final int? vacantPlaces;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'itinerary')
  final Map<String, String>? itinerary;

  TripModel({
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
  }) : super(
    startingPlace: startingPlace,
    startingDate: startingDate,
    arrivalPlace: arrivalPlace,
    arrivalDate: arrivalDate,
    durationDays: durationDays,
    image: image,
    costPerPerson: costPerPerson,
    vacantPlaces: vacantPlaces,
    description: description,
    itinerary: itinerary,
  );

  factory TripModel.fromJson(Map<String, dynamic> json) {
    log('🔔 JSON Response: $json');
    try {
      return _$TripModelFromJson(json);
    } catch (e, stackTrace) {
      log('❌ Error parsing JSON: $e\nStackTrace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$TripModelToJson(this);

  // دالة للتعامل مع القيم العددية (int) اللي ممكن تكون null
  static int _nullableIntFromJson(dynamic json, {int defaultValue = 0}) {
    if (json == null) {
      log('⚠️ Null value received for int field, returning default: $defaultValue');
      return defaultValue;
    }
    if (json is num) return json.toInt();
    if (json is String) {
      try {
        return int.parse(json);
      } catch (e) {
        log('❌ Failed to parse int from string: $json');
        return defaultValue;
      }
    }
    log('❌ Unexpected type for int field: ${json.runtimeType}, value: $json');
    return defaultValue;
  }

  static double? _nullableDoubleFromJson(dynamic json) {
    if (json == null) {
      log('⚠️ Null value received for double field, returning null');
      return null;
    }
    if (json is num) return json.toDouble();
    if (json is String) {
      try {
        return double.tryParse(json);
      } catch (e) {
        log('❌ Failed to parse double from string: $json');
        return null;
      }
    }
    log('❌ Unexpected type for double field: ${json.runtimeType}, value: $json');
    return null;
  }
}