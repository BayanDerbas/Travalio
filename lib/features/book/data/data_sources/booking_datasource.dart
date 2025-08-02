import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/networks/api_service.dart';
import '../../../../../core/networks/failures.dart';
import '../../../../core/networks/dio_factory.dart';
import '../models/booking_model.dart';

abstract class BookingDataSource {
  Future<Either<Failures, BookingModel>> bookTrip(BookingModel booking);
}

class BookingDataSourceImpl implements BookingDataSource {
  final ApiService apiService;

  BookingDataSourceImpl(this.apiService);

  @override
  Future<Either<Failures, BookingModel>> bookTrip(BookingModel booking) async {
    try {
      final token = await DioFactory.readToken();
      print('[bookTrip] token: $token');
      final data = booking.toJson();
      print('[bookTrip] sending data: $data');

      if (token != null) {
        final dio = DioFactory.getDio();
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final result = await apiService.bookTrip(data);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        print('[bookTrip] error response data: ${e.response?.data}');
      }
      return Left(serverFailure(e.toString()));
    }
  }
}
