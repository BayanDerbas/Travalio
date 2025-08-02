import 'package:travalio/features/discover/data/models/trip_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip_response.g.dart';

@JsonSerializable()
class TripsResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<TripModel> results;

  TripsResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory TripsResponse.fromJson(Map<String, dynamic> json) =>
      _$TripsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TripsResponseToJson(this);
}