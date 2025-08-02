import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travalio/core/di/injection.dart';
import 'package:travalio/core/routes/app_routes.dart';
import 'package:travalio/features/discover/presentation/bloc/tabButton/tab_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/navigation_bar_bottom/navigation_bloc.dart';
import '../bloc/trips/trips_bloc.dart';
import '../widgets/CustomBuildTripCard.dart';
import '../widgets/CustomTabButton.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TripsBloc(sl(), sl()),
        ),
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => TabBloc()),
      ],
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final tripsBloc = context.read<TripsBloc>();
            if (tripsBloc.state is TripsInitial) {
              tripsBloc.add(const FetchTrips(category: 'full-trips'));
            }
          });

          return Scaffold(
            backgroundColor: AppColors.white,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: AppColors.lightGrey,
              elevation: 0,
              title: const Text(
                'Discover',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.grey,
                ),
              ),
              centerTitle: true,
              leading: Container(
                margin: const EdgeInsets.only(left: 16),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.search, color: AppColors.smooky),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.push(AppRoutes.notification);
                    },
                    icon: const Icon(Icons.notifications_none),
                    color: AppColors.smooky,
                  ),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: BlocBuilder<TabBloc, TabState>(
                    builder: (context, state) {
                      final currentIndex = state is TabInitial ? state.index : 0;
                      final categories = ['full-trips', 'restaurants', 'hotels', 'tours'];
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CustomTabButton(
                              title: 'Full Trips',
                              isActive: currentIndex == 0,
                              index: 0,
                              category: categories[0],
                            ),
                            CustomTabButton(
                              title: 'Restaurants',
                              isActive: currentIndex == 1,
                              index: 1,
                              category: categories[1],
                            ),
                            CustomTabButton(
                              title: 'Hotels',
                              isActive: currentIndex == 2,
                              index: 2,
                              category: categories[2],
                            ),
                            CustomTabButton(
                              title: 'Tours',
                              isActive: currentIndex == 3,
                              index: 3,
                              category: categories[3],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<TripsBloc, TripsState>(
                    builder: (context, state) {
                      if (state is TripsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: AppColors.deepOrange),
                        );
                      } else if (state is TripsLoaded) {
                        if (state.trips.isEmpty) {
                          return const Center(child: Text('No trips available'));
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: state.trips.length,
                          itemBuilder: (context, index) {
                            final trip = state.trips[index];
                            return Column(
                              children: [
                                CustomTripCard(
                                  imageUrl: trip.image.isNotEmpty
                                      ? trip.image
                                      : 'https://via.placeholder.com/608x329', // Placeholder image
                                  from: trip.startingPlace,
                                  fromCity: trip.startingPlace,
                                  to: trip.arrivalPlace,
                                  toCity: trip.arrivalPlace,
                                  startDate: trip.startingDate,
                                  endDate: trip.arrivalDate,
                                  onPressed: () {
                                    context.push(AppRoutes.details, extra: trip);
                                  },
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                        );
                      } else if (state is TripsError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.message),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  final categories = ['full-trips', 'restaurants', 'hotels', 'tours'];
                                  final currentIndex = context.read<TabBloc>().state is TabInitial
                                      ? (context.read<TabBloc>().state as TabInitial).index
                                      : 0;
                                  context.read<TripsBloc>().add(FetchTrips(category: categories[currentIndex]));
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center(child: Text('Select a category to view trips'));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
