import 'package:e_commerce/app/app.dart';
import 'package:e_commerce/ui/auth/auth_screen.dart';
import 'package:e_commerce/ui/news_detail/news_detail_screen.dart';
import 'package:e_commerce/ui/push_notification/push_notification_screen.dart';
import 'package:flutter/material.dart';

import 'home/home_screen.dart';
import 'splash/splash_screen.dart';


class RouteNames {
  static const String homeScreen = "/home_screen";
  static const String authScreen = "/auth_screen";
  static const String splashScreen = "/";
  static const String appScreen = "/app_screen";
  static const String newsDetail = "/news_detail";
  static const String pushNotificationScreen = "/push_notification";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.appScreen:
        return MaterialPageRoute(
          builder: (context) => const App(),
        );
      case RouteNames.pushNotificationScreen:
        return MaterialPageRoute(
          builder: (context) => const PushNotificationScreen(),
        );
      case RouteNames.newsDetail:
        return MaterialPageRoute(
          builder: (context) {
            Map<String,dynamic> map = settings.arguments as Map<String,dynamic>;
            return NewsDetailScreen(newsModel: map["model"],index: map["index"],);
          },
        );
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.authScreen:
        return MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not found!"),
            ),
          ),
        );
    }
  }
}