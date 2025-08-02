import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travalio/core/constants/app_colors.dart';
import 'package:travalio/features/discover/presentation/bloc/tabButton/tab_bloc.dart';
import '../bloc/trips/trips_bloc.dart';

class CustomTabButton extends StatelessWidget {
  final String title;
  final int index;
  final bool isActive;
  final String category;

  const CustomTabButton({
    super.key,
    required this.title,
    required this.index,
    required this.category,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TabBloc>().add(TabChanged(index));
        context.read<TripsBloc>().add(FetchTrips(category: category)); // دايمًا ابعت الحدث
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.orange : AppColors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.deepOrange : AppColors.smooky,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}