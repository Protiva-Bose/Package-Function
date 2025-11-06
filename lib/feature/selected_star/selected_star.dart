import 'package:flutter/material.dart';

class SelectedStar extends StatefulWidget {
  const SelectedStar({super.key});

  @override
  State<SelectedStar> createState() => _SelectedStarState();
}

class _SelectedStarState extends State<SelectedStar> {
  int _selectedStars = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final isSelected = index < _selectedStars;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedStars = index + 1;
            });
          },
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: isSelected ? 1.2 : 1.0,
            child: Icon(
              Icons.star,
              size: 40,
              color: isSelected ? const Color(0xffFFA502) : Colors.grey[400],
            ),
          ),
        );
      }),
    );
  }
}
