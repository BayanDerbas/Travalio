import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../../data/models/booking_model.dart';
import '../../domain/repositories/booking_repository.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc(this.bookingRepository) : super(BookingInitial()) {
    on<BookTripEvent>((event, emit) async {
      emit(BookingLoading());
      final Either<Failures, BookingModel> failureOrBooking =
      await bookingRepository.bookTrip(event.booking);

      failureOrBooking.fold(
            (failure) {
          print('Booking failed: ${failure.err_message}');
          emit(BookingFailure(failure.err_message));
        },
            (booking) {
          print('Booking succeeded: ${booking.toString()}');
          emit(BookingSuccess(booking));
        },
      );
    });
  }
}
