import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/task_screen_page/task_screen.dart';
import 'package:to_do_app/utils/ui_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _navigateToNextScreen();
    super.initState();
  }

  void _navigateToNextScreen() async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const TaskScreen()),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.primary,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: UiColors.secondary,
            shape: BoxShape.circle
          ),
          child: Image.asset(
            'assets/icons/app_logo.png',
          width: 120.0,
          ),
        ),
      ),
    );
  }
}
