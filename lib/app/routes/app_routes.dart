import 'package:flutter/cupertino.dart';
import 'package:packages/feature/profile/profile_Screen.dart';
import '../../core/constant/route_names.dart';
import '../../feature/Dart/functions/+x_container/container_screen.dart';
import '../../feature/Dart/functions/dialog/dialog_screen.dart';
import '../../feature/Dart/functions/selected_star/selected_star.dart';
import '../../feature/Dart/packages/  table_calendar/Calender_screen.dart';
import '../../feature/Dart/packages/carousel_slider/carousel_Slider.dart';
import '../../feature/Dart/packages/shimmer_package/presentation/view/shimmer.dart';
import '../../feature/Dart/packages/signature/signature_Screen.dart';
import '../../feature/home/home_Screen.dart';
import '../../feature/splash/splash_screen.dart';

class AppRoutes {
  static String initialRoute = RouteNames.splashScreen;

  static final Map<String, WidgetBuilder> routes = {
    RouteNames.homeScreen: (context) => const HomeScreen(),
    RouteNames.shimmerScreen: (context) => const ShimmerScreen(),
    RouteNames.carouselSliderScreen: (context) =>  CarouselExample(),
    RouteNames.selectedStar: (context) =>  SelectedStar(),
    RouteNames.calenderScreen: (context) =>  CalenderScreen(),
    RouteNames.dialogScreen: (context) =>  DialogScreen(),
    RouteNames.signatureScreen: (context) =>  SignatureScreen(),
    RouteNames.xContainer: (context) =>  XContainer(),
    RouteNames.profileScreen: (context) =>  ProfileScreen(),
    RouteNames.splashScreen: (context) =>  SplashScreen(),

  };
}