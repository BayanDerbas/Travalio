import 'package:equatable/equatable.dart';
import '../../data/models/booking_model.dart';

abstract class BookingState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final BookingModel booking;

  BookingSuccess(this.booking);

  @override
  List<Object> get props => [booking];
}

class BookingFailure extends BookingState {
  final String message;

  BookingFailure(this.message);

  @override
  List<Object> get props => [message];
}
