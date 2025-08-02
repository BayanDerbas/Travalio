import 'package:dartz/dartz.dart';
import '../../../../core/networks/failures.dart';
import '../data_sources/booking_datasource.dart';
import '../models/booking_model.dart';
import '../../domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingDataSource bookingDataSource;

  BookingRepositoryImpl(this.bookingDataSource);

  @override
  Future<Either<Failures, BookingModel>> bookTrip(BookingModel booking) async {
    return await bookingDataSource.bookTrip(booking);
  }
}