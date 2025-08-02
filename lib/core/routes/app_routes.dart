import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travalio/features/book/presentation/screens/payment.dart';
import 'package:travalio/features/notifications/presentation/screens/notifications.dart';
import 'package:travalio/features/profile/presentation/screens/profile.dart';
import 'package:travalio/features/splash/screens/splash_screen.dart';
import '../../features/auth/presentation/screeens/auth.dart';
import '../../features/book/presentation/screens/book.dart';
import '../../features/discover/data/models/trip_model.dart';
import '../../features/discover/domain/entities/trip_entity.dart';
import '../../features/discover/presentation/bloc/navigation_bar_bottom/navigation_bloc.dart';
import '../../features/discover/presentation/bloc/tabButton/tab_bloc.dart';
import '../../features/discover/presentation/bloc/trips/trips_bloc.dart';
import '../../features/discover/presentation/screens/discover.dart';
import '../../features/discover/presentation/screens/main_screen.dart';
import '../../features/tripDetails/presentation/screens/trip_details_screen.dart';
import '../di/injection.dart';

// lib/core/routes/app_routes.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travalio/features/book/presentation/screens/payment.dart';
import 'package:travalio/features/notifications/presentation/screens/notifications.dart';
import 'package:travalio/features/profile/presentation/screens/profile.dart';
import 'package:travalio/features/splash/screens/splash_screen.dart';
import '../../features/auth/presentation/screeens/auth.dart';
import '../../features/book/presentation/screens/book.dart';
import '../../features/discover/domain/entities/trip_entity.dart';
import '../../features/discover/presentation/bloc/navigation_bar_bottom/navigation_bloc.dart';
import '../../features/discover/presentation/bloc/tabButton/tab_bloc.dart';
import '../../features/discover/presentation/bloc/trips/trips_bloc.dart';
import '../../features/discover/presentation/screens/discover.dart';
import '../../features/discover/presentation/screens/main_screen.dart';
import '../../features/tripDetails/presentation/screens/trip_details_screen.dart';
import '../../main.dart';
import '../di/injection.dart';

// lib/core/routes/app_routes.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travalio/features/book/presentation/screens/payment.dart';
import 'package:travalio/features/notifications/presentation/screens/notifications.dart';
import 'package:travalio/features/profile/presentation/screens/profile.dart';
import 'package:travalio/features/splash/screens/splash_screen.dart';
import '../../features/auth/presentation/screeens/auth.dart';
import '../../features/book/presentation/screens/book.dart';
import '../../features/discover/domain/entities/trip_entity.dart';
import '../../features/discover/presentation/bloc/navigation_bar_bottom/navigation_bloc.dart';
import '../../features/discover/presentation/bloc/tabButton/tab_bloc.dart';
import '../../features/discover/presentation/bloc/trips/trips_bloc.dart';
import '../../features/discover/presentation/screens/discover.dart';
import '../../features/discover/presentation/screens/main_screen.dart';
import '../../features/tripDetails/presentation/screens/trip_details_screen.dart';
import '../../main.dart';
import '../di/injection.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String register = '/register';
  static const String login = '/login';
  static const String home = '/home';
  static const String details = '/details/:tripId';
  static const String book = '/book';
  static const String payment = '/payment';
  static const String notification = '/notification';
  static const String profile = '/profile';

  static const String splashName = 'splash';
  static const String registerName = 'register';
  static const String loginName = 'login';
  static const String homeName = 'home';
  static const String detailsName = 'details';
  static const String bookName = 'book';
  static const String paymentName = 'payment';
  static const String notificationName = 'notification';
  static const String profileName = 'profile';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        builder: (context, state) => AuthScreen(routeState: state),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.registerName,
        builder: (context, state) => AuthScreen(routeState: state),
      ),
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainScreen(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: AppRoutes.homeName,
            builder: (context, state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => TripsBloc(sl(), sl())),
                  BlocProvider(create: (_) => NavigationBloc()),
                  BlocProvider(create: (_) => TabBloc()),
                ],
                child: const DiscoverScreen(),
              );
            },
          ),
          GoRoute(
            path: AppRoutes.profile,
            name: AppRoutes.profileName,
            builder: (context, state) => const Profile(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.notification,
        name: AppRoutes.notificationName,
        builder: (context, state) => const Notifications(),
      ),
      GoRoute(
        path: AppRoutes.details,
        name: AppRoutes.detailsName,
        builder: (context, state) {
          final trip = state.extra as TripModel?;
          if (trip == null) {
            return const Scaffold(
              body: Center(child: Text('Trip data not found')),
            );
          }
          return TripDetailsScreen(trip: trip);
        },
      ),
      GoRoute(
        path: AppRoutes.book,
        name: AppRoutes.bookName,
        builder: (context, state) {
          final trip = state.extra as TripModel?;
          if (trip == null) {
            return const Scaffold(
              body: Center(child: Text('Trip data not found')),
            );
          }
          return BookTripScreen(trip: trip);},
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) {
          final bookingData = state.extra as TripBookingData;
          return PaymentScreen(booking: bookingData);
        },
      ),
    ],
  );
}
