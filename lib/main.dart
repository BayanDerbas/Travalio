import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travalio/core/utils/check_connection.dart';
import 'package:travalio/features/discover/domain/usecases/trip_usecase.dart';
import 'core/di/injection.dart' as di;
import 'core/networks/dio_factory.dart';
import 'core/routes/app_routes.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';
import 'features/book/presentation/bloc/booking_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await DioFactory.loadToken();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkConnection(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => di.sl<RegisterUseCase>()),
        RepositoryProvider(create: (_) => di.sl<LoginUseCase>()),
        RepositoryProvider(create: (_) => di.sl<GetTripsUseCase>()),
        RepositoryProvider(create: (_) => di.sl<GetTripByIdUseCase>()),
        BlocProvider(create: (_) => di.sl<BookingBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
        title: 'Travalio',
      ),
    );
  }
}
