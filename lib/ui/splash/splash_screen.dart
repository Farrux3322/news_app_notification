import 'package:e_commerce/ui/app_routes.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(const Duration(seconds: 3));

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.white,statusBarIconBrightness:Brightness.dark),
        elevation: 0,
      ),
      body: Center(child: Lottie.asset("assets/images/hi.json"))
    );
  }
}
