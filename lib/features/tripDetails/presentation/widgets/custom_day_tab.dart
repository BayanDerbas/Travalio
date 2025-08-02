import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomDayTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CustomDayTab({
    super.key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Chip(
          backgroundColor: isSelected ? AppColors.orange : AppColors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected ? AppColors.orange : AppColors.white,
            ),
          ),
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.deepOrange : AppColors.smooky,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}