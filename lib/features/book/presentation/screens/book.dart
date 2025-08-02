import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travalio/core/routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../discover/data/models/trip_model.dart';

class BookTripScreen extends StatefulWidget {
  final TripModel trip;

  const BookTripScreen({super.key, required this.trip});

  @override
  State<BookTripScreen> createState() => _BookTripScreenState();
}

class _BookTripScreenState extends State<BookTripScreen> {
  final TextEditingController travelersController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.trip.description ?? "";
  }

  @override
  void dispose() {
    travelersController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F8FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F8FD),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.smooky),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Book a trip',
          style: TextStyle(
            color: AppColors.smooky,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField("Booking Name", nameController),

            _buildTextField("Trip Description", descriptionController),

            Row(
              children: [
                Expanded(child: _buildReadOnlyField("From", trip.startingPlace)),
                const SizedBox(width: 10),
                Expanded(child: _buildReadOnlyField("To", trip.arrivalPlace)),
              ],
            ),

            Row(
              children: [
                Expanded(child: _buildReadOnlyField("Start Date", trip.startingDate)),
                const SizedBox(width: 10),
                Expanded(child: _buildReadOnlyField("End Date", trip.arrivalDate)),
              ],
            ),

            _buildReadOnlyField("Duration", "${trip.durationDays} Days"),

            Row(
              children: [
                Expanded(child: _buildTextField("Travelers Number", travelersController)),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildReadOnlyField(
                    "Price",
                    trip.costPerPerson != null ? "${trip.costPerPerson}\$" : "N/A",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: 370,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (travelersController.text.isEmpty || nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }

                  final startDate = DateTime.parse(trip.startingDate);
                  final endDate = DateTime.parse(trip.arrivalDate);
                  final durationDays = endDate.difference(startDate).inDays + 1;

                  final booking = TripBookingData(
                    bookingName: nameController.text,
                    travelersNumber: int.tryParse(travelersController.text) ?? 1,
                    tripDescription: trip.description ?? "-",
                    fromPlace: trip.startingPlace,
                    toPlace: trip.arrivalPlace,
                    startDate: trip.startingDate,
                    endDate: trip.arrivalDate,
                    duration: durationDays,
                    tripPricePerPerson: trip.costPerPerson ?? 0.0,
                  );

                  context.push(AppRoutes.payment, extra: booking);
                },
                child: const Text(
                  "Complete",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: label.toLowerCase().contains("number") ? TextInputType.number : TextInputType.text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          enabled: false,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class TripBookingData {
  final String bookingName;
  final int travelersNumber;

  final String tripDescription;
  final String fromPlace;
  final String toPlace;
  final String startDate;
  final String endDate;
  final int duration;
  final double tripPricePerPerson;

  TripBookingData({
    required this.bookingName,
    required this.travelersNumber,
    required this.tripDescription,
    required this.fromPlace,
    required this.toPlace,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.tripPricePerPerson,
  });
}
