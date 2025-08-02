import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travalio/core/constants/app_colors.dart';
import 'package:travalio/core/constants/app_images.dart';
import 'package:travalio/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late AnimationController _buttonController;
  late Animation<Offset> _startOffset;
  late Animation<Offset> _loginOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _startOffset = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeOut));

    _loginOffset = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _buttonController.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lightBeige,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Column(
                children: [
                  Image.asset(
                    AppImages.logo,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'TRAVALIO',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepOrange,
                    ),
                  ),
                  const Text(
                    'YOUR TOURIST GUIDE',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.teal,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Plan, book, and enjoy every moment\nof your adventure with Travalio, your\nultimate tourism app',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),

          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: height * _animation.value,
                    color: AppColors.deepOrange,
                    child: Center(
                      child: Opacity(
                        opacity: _controller.isCompleted ? 1.0 : 0.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SlideTransition(
                              position: _startOffset,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.push(AppRoutes.register);
                                  },
                                  child: const Text('GET STARTED'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.white,
                                    foregroundColor: AppColors.deepOrange,
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SlideTransition(
                              position: _loginOffset,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                child: OutlinedButton(
                                  onPressed: () {
                                    context.push(AppRoutes.login);
                                  },
                                  child: const Text('I ALREADY HAVE AN ACCOUNT'),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: AppColors.white),
                                    foregroundColor: AppColors.white,
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.35);

    double waveWidth = size.width / 3;

    path.quadraticBezierTo(
      waveWidth * 0.5, size.height * 0.22,
      waveWidth, size.height * 0.30,
    );

    path.quadraticBezierTo(
      waveWidth * 1.5, size.height * 0.38,
      waveWidth * 2, size.height * 0.25,
    );

    path.quadraticBezierTo(
      waveWidth * 2.3, size.height * 0.16,
      size.width, size.height * 0.28,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}