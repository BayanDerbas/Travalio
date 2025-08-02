import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/auth/data/data_sources/auth_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecase.dart';
import '../../features/book/data/data_sources/booking_datasource.dart';
import '../../features/book/data/repositories/booking_repositoryImpl.dart';
import '../../features/book/domain/repositories/booking_repository.dart';
import '../../features/book/presentation/bloc/booking_bloc.dart';
import '../../features/discover/data/data_sources/trip_datasource.dart';
import '../../features/discover/data/repositories/trip_repositoryImpl.dart';
import '../../features/discover/domain/repositories/trip_repositories.dart';
import '../../features/discover/domain/usecases/trip_usecase.dart';
import '../../features/discover/presentation/bloc/trips/trips_bloc.dart';
import '../networks/api_service.dart';
import '../networks/dio_factory.dart';
import '../utils/secure_storage.dart';

final sl = GetIt.instance;

void init() {
  // Secure Storage
  sl.registerLazySingleton<SecureStorage>(() => SecureStorage());

  // Dio
  sl.registerLazySingleton<Dio>(() => DioFactory.getDio());

  // ApiService
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<TripRemoteDataSource>(
        () => TripRemoteDataSourceImpl(sl<ApiService>()),
  );
  sl.registerLazySingleton<BookingDataSource>(
        () => BookingDataSourceImpl(sl<ApiService>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<SecureStorage>(),
    ),
  );
  sl.registerLazySingleton<TripRepository>(
        () => TripRepositoryImpl(sl<TripRemoteDataSource>()),
  );
  sl.registerLazySingleton<BookingRepository>(
        () => BookingRepositoryImpl(sl<BookingDataSource>()),
  );

  // Blocs
  sl.registerLazySingleton<TripsBloc>(() => TripsBloc(sl<GetTripsUseCase>(), sl<GetTripByIdUseCase>()));
  sl.registerLazySingleton<BookingBloc>(
        () => BookingBloc(sl<BookingRepository>()),
  );

  // Use cases
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<GetTripsUseCase>(() => GetTripsUseCase(sl<TripRepository>()));
  sl.registerLazySingleton<GetTripByIdUseCase>(() => GetTripByIdUseCase(sl<TripRepository>()));
}