import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  @JsonKey(name: 'booking_name')
  final String? bookingName;

  @JsonKey(name: 'trip_description')
  final String? tripDescription;

  @JsonKey(name: 'from_place')
  final String? fromPlace;

  @JsonKey(name: 'to_place')
  final String? toPlace;

  @JsonKey(name: 'start_date')
  final String? startDate;

  @JsonKey(name: 'end_date')
  final String? endDate;

  final int? duration;

  @JsonKey(name: 'travelers_number')
  final int? travelersNumber;

  @JsonKey(name: 'trip_price_per_person')
  final double? tripPricePerPerson;

  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  @JsonKey(name: 'card_holder_name')
  final String? cardHolderName;

  @JsonKey(name: 'card_number')
  final String? cardNumber;

  final String? expiry;
  final String? cvc;

  BookingModel({
    required this.bookingName,
    required this.tripDescription,
    required this.fromPlace,
    required this.toPlace,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.travelersNumber,
    required this.tripPricePerPerson,
    required this.paymentMethod,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiry,
    required this.cvc,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}