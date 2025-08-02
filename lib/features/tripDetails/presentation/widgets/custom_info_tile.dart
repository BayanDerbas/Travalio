import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class CustomInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const CustomInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 2) - 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: AppColors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppColors.smooky,
            ),
          ),
        ],
      ),
    );
  }
}
