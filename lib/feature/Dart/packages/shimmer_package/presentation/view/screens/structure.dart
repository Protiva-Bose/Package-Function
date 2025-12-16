import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Structure extends StatefulWidget {
  const Structure({super.key});

  @override
  State<Structure> createState() => _StructureState();
}
class _StructureState extends State<Structure> {

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

      body: _isLoading ?

      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            ShimmerItem(),
            ShimmerItem(),
            ShimmerItem(),
          ],
        ),
      ):

      SafeArea(
        top: false,
        child: Center(
          child: Text('Main Screen Code'),
        ),
      ),
    );
  }
}

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 40.0,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 40.0,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 30.0,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 100,
                    height: 30.0,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 100,
                    height: 30.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
