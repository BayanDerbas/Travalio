import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../../data/models/booking_model.dart';

abstract class BookingRepository {
  Future<Either<Failures, BookingModel>> bookTrip(BookingModel booking);
}