import 'package:equatable/equatable.dart';

import '../../data/models/booking_model.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookTripEvent extends BookingEvent {
  final BookingModel booking;

  BookTripEvent(this.booking);

  @override
  List<Object> get props => [booking];
}
