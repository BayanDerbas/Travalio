import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travalio/core/routes/app_routes.dart';
import 'package:travalio/features/tripDetails/presentation/widgets/custom_day_tab.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../discover/data/models/trip_model.dart';
import '../widgets/custom_trip_details.dart';

class TripDetailsScreen extends StatefulWidget {
  final TripModel trip;

  const TripDetailsScreen({super.key, required this.trip});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  int selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    final itinerary = widget.trip.itinerary ?? {};
    final days = itinerary.keys.toList();

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                widget.trip.image,
                height: 270,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 270,
                    width: double.infinity,
                    color: AppColors.grey,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.deepOrange,
                        strokeWidth: 4,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 270,
                    width: double.infinity,
                    color: AppColors.grey,
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: AppColors.white, size: 40),
                    ),
                  );
                },
              ),
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Trip Details",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.trip.arrivalPlace,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(offset: Offset(0, 1), blurRadius: 2, color: Colors.black)],
                    ),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTripDetails(
                      duration: widget.trip.durationDays.toString(),
                      tripType: "A flight",
                      startDate: widget.trip.startingDate,
                      endDate: widget.trip.arrivalDate,
                      startingPlace: widget.trip.startingPlace,
                      arrivalArea: widget.trip.arrivalPlace,
                      costPerPerson: "${widget.trip.costPerPerson ?? 'N/A'}\$",
                      vacantPlaces: widget.trip.vacantPlaces ?? 0,
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "Trip Description:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(widget.trip.description ?? "-", style: TextStyle(color: AppColors.smooky)),

                    const SizedBox(height: 20),
                    Text(
                      "Details of the trip days:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.grey),
                    ),
                    const SizedBox(height: 10),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: (days.isNotEmpty
                            ? days.asMap().entries.map((entry) {
                          final index = entry.key;
                          final day = entry.value;
                          return CustomDayTab(
                            label: day,
                            isSelected: index == selectedDayIndex,
                            onTap: () {
                              setState(() {
                                selectedDayIndex = index;
                              });
                            },
                          );
                        }).toList()
                            : List.generate(3, (index) => CustomDayTab(label: "Day ${index + 1}", onTap: () {  },))),
                      ),
                    ),

                    const SizedBox(height: 10),

                    if (days.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            days[selectedDayIndex].toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            itinerary[days[selectedDayIndex]] ?? '',
                            style: TextStyle(color: AppColors.smooky),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    else
                      Text(
                        "No itinerary available for this trip.",
                        style: TextStyle(color: AppColors.smooky, fontStyle: FontStyle.italic),
                      ),

                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deepOrange,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () => context.push(AppRoutes.book, extra: widget.trip),
                          child: const Text("Book your seat", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
