// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripsResponse _$TripsResponseFromJson(Map<String, dynamic> json) =>
    TripsResponse(
      count: (json['count'] as num).toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results:
          (json['results'] as List<dynamic>)
              .map((e) => TripModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$TripsResponseToJson(TripsResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
