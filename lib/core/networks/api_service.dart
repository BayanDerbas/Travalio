import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/auth/data/models/login_response.dart';
import '../../features/auth/data/models/register_response.dart';
import '../../features/book/data/models/booking_model.dart';
import '../../features/discover/data/models/trip_model.dart';
import '../../features/discover/data/models/trip_response.dart';
import 'api_constant.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/register/")
  Future<RegisterResponse> register(@Body() Map<String, dynamic> body);

  @POST(ApiConstant.login)
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  @GET(ApiConstant.trips)
  Future<TripsResponse> getTrips({@Query("category") String? category});

  @GET(ApiConstant.tripsId)
  Future<TripModel> getTripById(@Path("trip_id") int tripId);

  @POST("/book-trip/")
  Future<BookingModel> bookTrip(@Body() Map<String, dynamic> bookingData);
}
