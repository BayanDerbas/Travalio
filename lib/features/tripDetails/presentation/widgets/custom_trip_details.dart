import 'package:flutter/material.dart';
import 'custom_info_tile.dart';

class CustomTripDetails extends StatelessWidget {
  final String duration;
  final String tripType;
  final String startDate;
  final String endDate;
  final String startingPlace;
  final String arrivalArea;
  final String costPerPerson;
  final int vacantPlaces;

  const CustomTripDetails({
    super.key,
    required this.duration,
    required this.tripType,
    required this.startDate,
    required this.endDate,
    required this.startingPlace,
    required this.arrivalArea,
    required this.costPerPerson,
    required this.vacantPlaces,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: [
        CustomInfoTile(title: "Duration", value: duration),
        CustomInfoTile(title: "Trip type", value: tripType),
        CustomInfoTile(title: "Start Date", value: startDate),
        CustomInfoTile(title: "End Date", value: endDate),
        CustomInfoTile(title: "Starting Place", value: startingPlace),
        CustomInfoTile(title: "Arrival Area", value: arrivalArea),
        CustomInfoTile(
          title: "Cost per person",
          value: costPerPerson,
          valueColor: Colors.green,
        ),
        CustomInfoTile(
            title: "Vacant places", value: vacantPlaces.toString()),
      ],
    );
  }
}
