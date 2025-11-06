import 'package:flutter/material.dart';

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
