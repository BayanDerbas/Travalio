import 'package:flutter/material.dart';
import 'dart:developer';
import '../../../../core/constants/app_colors.dart';

// lib/features/discover/presentation/widgets/CustomBuildTripCard.dart
import 'package:flutter/material.dart';
import 'dart:developer';
import '../../../../core/constants/app_colors.dart';

// lib/features/discover/presentation/widgets/CustomBuildTripCard.dart
import 'package:flutter/material.dart';
import 'dart:developer';
import '../../../../core/constants/app_colors.dart';

class CustomTripCard extends StatelessWidget {
  final String imageUrl;
  final String from;
  final String fromCity;
  final String to;
  final String toCity;
  final String startDate;
  final String endDate;
  final VoidCallback onPressed;

  const CustomTripCard({
    super.key,
    required this.imageUrl,
    required this.from,
    required this.fromCity,
    required this.to,
    required this.toCity,
    required this.startDate,
    required this.endDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Image.network(
                imageUrl, // استخدام imageUrl مباشرة بدون استبدال
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180,
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
                  log('❌ Error loading image in CustomTripCard: $error');
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: AppColors.grey,
                    child: const Center(child: Icon(Icons.error, color: AppColors.white, size: 40)),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '$from / $fromCity',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          startDate,
                          style: const TextStyle(color: AppColors.grey, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '$to / $toCity',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          endDate,
                          style: const TextStyle(color: AppColors.grey, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Trip duration:',
                          style: TextStyle(color: AppColors.grey, fontSize: 14),
                        ),
                        Text(
                          '${_calculateDays(startDate, endDate)} Days',
                          style: const TextStyle(color: AppColors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _calculateDays(String start, String end) {
    try {
      final s = DateTime.parse(start.split('/').reversed.join());
      final e = DateTime.parse(end.split('/').reversed.join());
      return e.difference(s).inDays.toString();
    } catch (e) {
      return 'N/A';
    }
  }
}