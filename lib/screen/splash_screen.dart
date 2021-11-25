import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant/common/navigate.dart';
import 'package:restaurant/constant/screen_const.dart';

import '../di.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..forward();
    Timer(
      Duration(seconds: 3),
      () => inject<Navigate>()
          .navigateTo(ScreenConst.RestaurantList, replace: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/restaurant.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
