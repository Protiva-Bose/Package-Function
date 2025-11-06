import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/widgets/shimmer_box/shimmer.dart';

class ShimmerScreen extends StatefulWidget {
  const ShimmerScreen({super.key});

  @override
  State<ShimmerScreen> createState() => _ShimmerScreenState();
}

class _ShimmerScreenState extends State<ShimmerScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading? Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            ShimmerItem(),
            ShimmerItem(),
            ShimmerItem(),
          ],
        ),
      ):SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Stack(
                children: [
                  SvgPicture.asset('assets/images/appbar.svg',fit: BoxFit.cover,),
                  Positioned(
                    top: 40.h,
                    left: 20.w,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                           // Navigator.pushNamed(context, RouteNames.editProfile);
                          },
                          child: Image.asset(
                            'assets/images/user.png',
                            scale: 0.8,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, Jonathan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Ready for your next test?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 50.w),
                        Container(
                          width: 49.w,
                          height: 38.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   RouteNames.notificationScreen,
                                    // );
                                  },
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/Notification icon.svg',
                                      width: 22.w,
                                      height: 22.h,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 22.h,
                                  left: 23.w,
                                  child: SvgPicture.asset(
                                    'assets/icons/Border.svg',
                                    width: 8.w,
                                    height: 8.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 98.h,
                    left: 20.w,
                    right: 20.w,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 5.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    spacing: 20.h,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.h,
                        decoration: BoxDecoration(
                          color: Color(0xff2E6BB1),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 15.h,
                              left: 20.w,
                              child: Text(
                                textAlign: TextAlign.start,
                                'Book Your Medical\nTest Easily From\nHome',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 15.h,
                              left: 20.w,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25.w,
                                    vertical: 7.h,
                                  ),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  elevation: 0, // keep the button flat
                                ),
                                onPressed: () {
                                 // Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen()));
                                },
                                child: Text(
                                  'Book Now',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40.h,
                              left: 165.w,
                              child: SvgPicture.asset(
                                'assets/images/home_icon.svg',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Book Popular Tests',
                            style: TextStyle(
                              color: Color(0xff1D1F2C),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: 7.h,
                              ),
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide.none,
                              ),
                            ),
                            onPressed: () {
                              // Navigator.pushNamed(
                              //   context,
                              //   RouteNames.bookPopularTestScreen,
                              // );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Color(0xff2D6BB4),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Color(0xff2D6BB4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 158.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: Container(
                                width: 125.w,
                                height: 160.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: const Color(0xffE5E5E5),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    spacing: 10.h,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/popular_test1.svg',
                                        width: 30.h,
                                        height: 30.h,
                                      ),
                                      Text(
                                        'Blood Tests',
                                        style: TextStyle(
                                          color: const Color(0xff1D1F2C),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: const Color(0xff777980),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              children: const [
                                                TextSpan(text: '20 labs '),
                                                TextSpan(text: '• '),
                                                TextSpan(text: '4h'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 14.w,
                                            vertical: 2.h,
                                          ),
                                          backgroundColor: const Color(
                                            0xff2D6BB4,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () {
                                         // Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen()));
                                        },
                                        child: Text(
                                          'Book Now',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'Current Requests (2)',
                          style: TextStyle(
                            color: Color(0xff1D1F2C),
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 155.h,
                        decoration: BoxDecoration(
                          color: Color(0xffF8FAFB),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Color(0xffE5E5E5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 45.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/popular_test1.svg',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'Blood Tests',
                                    style: TextStyle(
                                      color: Color(0xff1D1F2C),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14.w,
                                        vertical: 2.h,
                                      ),
                                      backgroundColor: const Color(0xffECF8F4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Complete',
                                      style: TextStyle(
                                        color: Color(0xff3DB88B),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 50.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    spacing: 5,
                                    children: [
                                      Row(
                                        spacing: 8,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/report.svg',
                                            width: 16.w,
                                            height: 16.h,
                                          ),
                                          Text(
                                            'Report in 6 hrs',
                                            style: TextStyle(
                                              color: Color(0xff777980),
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        spacing: 8,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/lab_test.svg',
                                            width: 16.w,
                                            height: 16.h,
                                          ),
                                          Text(
                                            'Al-Salam Medical Lab',
                                            style: TextStyle(
                                              color: Color(0xff777980),
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Divider(color: Color(0xffA5A5AB), thickness: 1),

                              Row(
                                children: [
                                  Text(
                                    '50 KD',
                                    style: TextStyle(
                                      color: Color(0xff1D1F2C),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14.w,
                                        vertical: 4.h,
                                      ),
                                      backgroundColor: const Color(0xff2D6BB4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         ResultScreen(),
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                      'View Results',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'Doctors & Dietitians Coming Soon',
                          style: TextStyle(
                            color: Color(0xff1D1F2C),
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      DoctorCarousel(),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCarousel extends StatefulWidget {
  const DoctorCarousel({super.key});

  @override
  State<DoctorCarousel> createState() => _DoctorCarouselState();
}

class _DoctorCarouselState extends State<DoctorCarousel> {
  final ValueNotifier<int> currentIndex = ValueNotifier(0);

  final List<Map<String, String>> doctorCards = [
    {
      'title': 'Future doctors will\nappear.',
      'subtitle': 'Meet our healthcare\nspecialists here.',
      'img1': 'assets/images/user.png',
      'img2': 'assets/images/user.png',
      'img3': 'assets/images/user.png',
      'img4': 'assets/images/user.png',
    },
    {
      'title': 'Your health, our priority.',
      'subtitle': 'Book appointments instantly.',
      'img1': 'assets/images/user.png',
      'img2': 'assets/images/user.png',
      'img3': 'assets/images/user.png',
      'img4': 'assets/images/user.png',
    },
    {
      'title': 'Expert care awaits.',
      'subtitle': 'Connect with top doctors.',
      'img1': 'assets/images/user.png',
      'img2': 'assets/images/user.png',
      'img3': 'assets/images/user.png',
      'img4': 'assets/images/user.png',
    },
    {
      'title': 'Future doctors will\nappear.',
      'subtitle': 'Meet our healthcare\nspecialists here.',
      'img1': 'assets/images/user.png',
      'img2': 'assets/images/user.png',
      'img3': 'assets/images/user.png',
      'img4': 'assets/images/user.png',
    },
    {
      'title': 'Your health, our priority.',
      'subtitle': 'Book appointments instantly.',
      'img1': 'assets/images/user.png',
      'img2': 'assets/images/user.png',
      'img3': 'assets/images/user.png',
      'img4': 'assets/images/user.png',
    },
    {
      'title': 'Expert care awaits.',
      'subtitle': 'Connect with top doctors.',
      'img1': 'assets/images/user.png',
      'img2': 'assets/images/user.png',
      'img3': 'assets/images/user.png',
      'img4': 'assets/images/user.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          itemCount: doctorCards.length,
          options: CarouselOptions(
            height: 130.h,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            onPageChanged: (index, _) => currentIndex.value = index,
          ),
          itemBuilder: (context, index, realIndex) {
            final item = doctorCards[index];
            return _buildDoctorCard(item);
          },
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<int>(
          valueListenable: currentIndex,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                doctorCards.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: value == index ? 14 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: value == index
                        ? const Color(0xff2E6BB1)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDoctorCard(Map<String, String> data) {
    return Container(
      width: double.infinity,
      height: 120.h,
      decoration: BoxDecoration(
        color: const Color(0xff2E6BB1),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [

          Positioned(
            top: 8.h,
            left: 20.w,
            right: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  data['title'] ?? '',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  data['subtitle'] ?? '',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: const Color(0xffE9E9EA),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          if (data['img1'] != null)
            Positioned(
              top: 40.h,
              right: 10.w,
              child: _buildCircleImage(data['img1']!, 30.w, 30.h),
            ),
          if (data['img2'] != null)
            Positioned(
              top: 30.h,
              right: 60.w,
              child: _buildCircleImage(data['img2']!, 36.w, 36.h),
            ),
          if (data['img3'] != null)
            Positioned(
              top: 90.h,
              right: 55.w,
              child: _buildCircleImage(data['img3']!, 25.w, 25.h),
            ),
          if (data['img4'] != null)
            Positioned(
              top: 80.h,
              right: 20.w,
              child: _buildCircleImage(data['img4']!, 25.w, 25.h),
            ),
        ],
      ),
    );
  }

  Widget _buildCircleImage(String path, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xffE9E9EA), width: 2),
      ),
      child: ClipOval(
        child: Image.asset(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
