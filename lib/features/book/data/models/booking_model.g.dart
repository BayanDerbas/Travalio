// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
  bookingName: json['booking_name'] as String?,
  tripDescription: json['trip_description'] as String?,
  fromPlace: json['from_place'] as String?,
  toPlace: json['to_place'] as String?,
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  travelersNumber: (json['travelers_number'] as num?)?.toInt(),
  tripPricePerPerson: (json['trip_price_per_person'] as num?)?.toDouble(),
  paymentMethod: json['payment_method'] as String?,
  cardHolderName: json['card_holder_name'] as String?,
  cardNumber: json['card_number'] as String?,
  expiry: json['expiry'] as String?,
  cvc: json['cvc'] as String?,
);

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'booking_name': instance.bookingName,
      'trip_description': instance.tripDescription,
      'from_place': instance.fromPlace,
      'to_place': instance.toPlace,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'duration': instance.duration,
      'travelers_number': instance.travelersNumber,
      'trip_price_per_person': instance.tripPricePerPerson,
      'payment_method': instance.paymentMethod,
      'card_holder_name': instance.cardHolderName,
      'card_number': instance.cardNumber,
      'expiry': instance.expiry,
      'cvc': instance.cvc,
    };
