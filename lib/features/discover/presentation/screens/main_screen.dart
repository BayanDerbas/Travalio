import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: SizedBox(
            height: 80,
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go(AppRoutes.home);
                    break;
                  case 1:
                    context.go(AppRoutes.home);
                    break;
                  case 2:
                    context.go(AppRoutes.home);
                    break;
                  case 3:
                    context.go(AppRoutes.home);
                    break;
                  case 4:
                    context.go(AppRoutes.profile);
                    break;
                }
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.white,
              selectedItemColor: AppColors.deepOrange,
              unselectedItemColor: AppColors.smooky,
              items: List.generate(
                5,
                    (i) => _buildNavItem(i, currentIndex),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.home)) return 0;
    if (location.startsWith(AppRoutes.home)) return 1;
    if (location.startsWith(AppRoutes.home)) return 2;
    if (location.startsWith(AppRoutes.home)) return 3;
    if (location.startsWith(AppRoutes.profile)) return 4;
    return 0;
  }

  BottomNavigationBarItem _buildNavItem(int index, int currentIndex) {
    final icons = [
      Icons.home_outlined,
      Icons.favorite_border,
      Icons.flight_outlined,
      Icons.menu_book_outlined,
      Icons.person_outline,
    ];

    final isSelected = index == currentIndex;

    return BottomNavigationBarItem(
      label: '',
      icon: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.deepOrange : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icons[index],
          size: 35,
          color: isSelected ? AppColors.white : AppColors.smooky,
        ),
      ),
    );
  }
}
