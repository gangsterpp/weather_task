import 'package:flutter/material.dart';
import 'package:weather/common/consts.dart';
import 'package:weather/home/home.page.dart';
import 'package:weather/infocurrent/infoCurrent.page.dart';
import 'package:weather/infomany/infoMany.page.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case (homePath):
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case (infoCurrentPath):
        return MaterialPageRoute(
          builder: (context) => InfoCurrentPage(
            cityName: settings.arguments as String,
          ),
        );
      case (infoManyPath):
        return MaterialPageRoute(
          builder: (context) => InfoManyPage(
            cityName: settings.arguments as String,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
