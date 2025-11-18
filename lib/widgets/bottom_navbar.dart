import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Color secondaryPurple;
  final Color secondaryPink;
  final Color primaryDark;

  const BottomNavBar({
    super.key,
    required this.secondaryPurple,
    required this.secondaryPink,
    required this.primaryDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [secondaryPurple, secondaryPink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home, color: Colors.white, size: 30),
          Icon(Icons.trending_up, color: Colors.white70, size: 30),
          SizedBox(width: 40),
          Icon(Icons.chat_bubble_outline, color: Colors.white70, size: 30),
          Icon(Icons.person_outline, color: Colors.white70, size: 30),
        ],
      ),
    );
  }
}
