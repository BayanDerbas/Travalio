import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travalio/features/book/data/models/booking_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';
import 'book.dart';
import 'booking_success.dart';

class PaymentScreen extends StatefulWidget {
  final TripBookingData booking;

  const PaymentScreen({super.key, required this.booking});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  final Map<String, String> paymentMethodApiValues = {
    'Visa': 'visa',
    'Stripe': 'stripe',
    'PayPal': 'paypal',
    'MasterCard': 'mastercard',
    'GooglePay': 'google_pay',
  };

  String selectedPaymentMethod = 'Visa';

  @override
  void dispose() {
    cardHolderNameController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const BookingSuccessDialog(),
          );
        } else if (state is BookingFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9F8FD),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF9F8FD),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.smooky),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: const Text(
              'Book a trip',
              style: TextStyle(
                color: AppColors.smooky,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment methods',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildPaymentMethod('assets/images/visa.png', 'Visa'),
                        const SizedBox(width: 10),
                        _buildPaymentMethod('assets/images/stripe.png', 'Stripe'),
                        const SizedBox(width: 10),
                        _buildPaymentMethod('assets/images/paypal.png', 'PayPal'),
                        const SizedBox(width: 10),
                        _buildPaymentMethod('assets/images/mastercard.png', 'MasterCard'),
                        const SizedBox(width: 10),
                        _buildPaymentMethod('assets/images/googlepay.png', 'GooglePay'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Card details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  _buildTextField('Cardholder’s name', 'Seen on your card', cardHolderNameController),
                  _buildTextField('Card number', 'Seen on your card', cardNumberController),
                  Row(
                    children: [
                      Expanded(child: _buildTextField('Expiry', '12/26', expiryController)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTextField('CVC', '654', cvcController)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is BookingLoading
                          ? null
                          : () {
                        if (cardHolderNameController.text.isEmpty ||
                            cardNumberController.text.isEmpty ||
                            expiryController.text.isEmpty ||
                            cvcController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill all payment fields')),
                          );
                          return;
                        }

                        if (!paymentMethodApiValues.containsKey(selectedPaymentMethod)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid payment method selected')),
                          );
                          return;
                        }

                        final bookingModel = BookingModel(
                          bookingName: widget.booking.bookingName,
                          tripDescription: widget.booking.tripDescription,
                          fromPlace: widget.booking.fromPlace,
                          toPlace: widget.booking.toPlace,
                          startDate: widget.booking.startDate,
                          endDate: widget.booking.endDate,
                          duration: widget.booking.duration,
                          travelersNumber: widget.booking.travelersNumber,
                          tripPricePerPerson: widget.booking.tripPricePerPerson,
                          paymentMethod: paymentMethodApiValues[selectedPaymentMethod]!,
                          cardHolderName: cardHolderNameController.text,
                          cardNumber: cardNumberController.text,
                          expiry: expiryController.text,
                          cvc: cvcController.text,
                        );

                        context.read<BookingBloc>().add(BookTripEvent(bookingModel));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: state is BookingLoading
                          ? const CircularProgressIndicator(color: AppColors.white)
                          : const Text(
                        'Confirm payment and booking',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentMethod(String assetPath, String method) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedPaymentMethod == method ? AppColors.deepOrange : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Center(
          child: Image.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
