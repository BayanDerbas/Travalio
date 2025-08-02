import 'dart:developer';
import 'package:bloc/bloc.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../../domain/usecases/trip_usecase.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final GetTripsUseCase getTripsUseCase;
  final GetTripByIdUseCase getTripByIdUseCase;

  TripsBloc(this.getTripsUseCase, this.getTripByIdUseCase) : super(TripsInitial()) {
    on<FetchTrips>(_onFetchTrips);
    on<FetchTripById>(_onFetchTripById);
  }

  Future<void> _onFetchTrips(FetchTrips event, Emitter<TripsState> emit) async {
    final category = event.category ?? 'all';
    log('🔔 جاري جلب الرحلات لفئة: $category');
    emit(TripsLoading());

    final result = await getTripsUseCase(category: event.category);

    result.fold(
          (failure) {
        log('❌ فشل جلب الرحلات - السبب: ${failure.err_message}');
        emit(TripsError(failure.err_message));
      },
          (trips) {
        log('✅ تم جلب الرحلات بنجاح - عدد الرحلات: ${trips.length}');
        emit(TripsLoaded(trips));
      },
    );
  }

  Future<void> _onFetchTripById(FetchTripById event, Emitter<TripsState> emit) async {
    log('🔔 جاري جلب الرحلة ${event.id}');
    emit(TripsLoading());

    final result = await getTripByIdUseCase(id: event.id);

    result.fold(
          (failure) {
        log('❌ فشل جلب الرحلة ${event.id} - السبب: ${failure.err_message}');
        emit(TripsError(failure.err_message));
      },
          (trip) {
        log('✅ تم جلب الرحلة ${event.id} بنجاح');
        emit(TripLoaded(trip));
      },
    );
  }

  void fetchTripsByCategory(String? category) {
    add(FetchTrips(category: category));
  }

  void fetchTripById(int id) {
    add(FetchTripById(id));
  }
}

// class TripsBloc extends Bloc<TripsEvent, TripsState> {
//   final GetTripsUseCase getTripsUseCase;
//   final GetTripByIdUseCase getTripByIdUseCase;
//
//   TripsBloc(this.getTripsUseCase, this.getTripByIdUseCase) : super(TripsInitial()) {
//     on<FetchTrips>(_onFetchTrips);
//     on<FetchTripById>(_onFetchTripById);
//   }
//
//   Future<void> _onFetchTrips(FetchTrips event, Emitter<TripsState> emit) async {
//     final category = event.category ?? 'all';
//     log('🔔 جاري جلب الرحلات لفئة: $category');
//     emit(TripsLoading());
//
//     final result = await getTripsUseCase(category: event.category);
//
//     result.fold(
//           (failure) {
//         log('❌ فشل جلب الرحلات - السبب: ${failure.err_message}');
//         emit(TripsError(failure.err_message));
//       },
//           (trips) {
//         log('✅ تم جلب الرحلات بنجاح - عدد الرحلات: ${trips.length}');
//         emit(TripsLoaded(trips));
//       },
//     );
//   }
//
//   Future<void> _onFetchTripById(FetchTripById event, Emitter<TripsState> emit) async {
//     log('🔔 جاري جلب الرحلة $event.id');
//     emit(TripsLoading());
//
//     final result = await getTripByIdUseCase(id: event.id);
//
//     result.fold(
//           (failure) {
//         log('❌ فشل جلب الرحلة $event.id - السبب: ${failure.err_message}');
//         emit(TripsError(failure.err_message));
//       },
//           (trip) {
//         log('✅ تم جلب الرحلة $event.id بنجاح');
//         emit(TripLoaded(trip));
//       },
//     );
//   }
//
//   void fetchTripsByCategory(String? category) {
//     add(FetchTrips(category: category));
//   }
//
//   void fetchTripById(int id) {
//     add(FetchTripById(id));
//   }
//
// }
