import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class XContainer extends StatefulWidget {
  const XContainer({super.key});

  @override
  State<XContainer> createState() => _XContainerState();
}
class _XContainerState extends State<XContainer> {

  bool _showAllTags = false;

  final List<String> tags = [
    'Gratitude',
    'Peace',
    'Mindfulness',
    'Growth',
    'Hope',
    'Focus'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffC6A664)),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 15,
                  children: [
                    Text(
                      'Today I woke up feeling grateful for the small moments that bring joy. The sunrise reminded me that each day is a new beginning...',
                      style: TextStyle(
                        color: const Color(0xff4A4C56),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(
                      height: 25.h,
                      child: ListView.builder(
                        itemCount: _showAllTags
                            ? tags.length
                            : (tags.length > 2 ? 3 : tags.length),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {

                          if (!_showAllTags &&
                              index == 2 &&
                              tags.length > 2) {
                            int remaining = tags.length - 2;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showAllTags = true;
                                });
                              },
                              child: Container(
                                width: 40.w,
                                height: 20.h,
                                margin: EdgeInsets.only(right: 8.w),
                                decoration: BoxDecoration(
                                  color: Color(0xffC6A664),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Text(
                                    '+$remaining',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }

                          // Normal tag container
                          return Container(
                            width: 80.w,
                            height: 20.h,
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: BoxDecoration(
                              color: const Color(0xffC6A664),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Text(
                                tags[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
