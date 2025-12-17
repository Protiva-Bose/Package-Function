import 'package:flutter/material.dart';
import '../profile/profile_Screen.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      {'icon': 'assets/icons/dart.png', 'label': 'Dart'},
      {'icon': 'assets/images/profile.png', 'label': 'Profile'},
    ];

    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = currentIndex == index;
            return GestureDetector(
              onTap: () {
                if (index == 1) {
                  // Open Profile Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                     // builder: (_) => const Practice(),
                    ),
                  );
                } else {
                  onTap(index);
                }
              },
              child: AnimatedContainer(
                height: 60,
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      items[index]['icon'] as String,
                      scale: 4.2,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.grey,
                        fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
