import 'package:flutter/cupertino.dart';
import '../../core/constant/route_names.dart';
import '../../feature/  table_calendar/Calender_screen.dart';
import '../../feature/+x_container/container_screen.dart';
import '../../feature/carousel_slider/carousel_Slider.dart';
import '../../feature/dialog/dialog_screen.dart';
import '../../feature/home/home_Screen.dart';
import '../../feature/selected_star/selected_star.dart';
import '../../feature/shimmer_package/presentation/view/shimmer.dart';
import '../../feature/signature/signature_Screen.dart';

class AppRoutes {
  static String initialRoute = RouteNames.homeScreen;

  static final Map<String, WidgetBuilder> routes = {
    RouteNames.homeScreen: (context) => const HomeScreen(),
    RouteNames.shimmerScreen: (context) => const ShimmerScreen(),
    RouteNames.carouselSliderScreen: (context) =>  CarouselExample(),
    RouteNames.selectedStar: (context) =>  SelectedStar(),
    RouteNames.calenderScreen: (context) =>  CalenderScreen(),
    RouteNames.dialogScreen: (context) =>  DialogScreen(),
    RouteNames.signatureScreen: (context) =>  SignatureScreen(),
    RouteNames.xContainer: (context) =>  XContainer(),

  };
}