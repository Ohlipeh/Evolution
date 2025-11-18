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

  void _navigate(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

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
        children: [
          // HOME
          GestureDetector(
            onTap: () => _navigate(context, '/home'),
            child: const Icon(Icons.home, color: Colors.white, size: 30),
          ),

          // PROGRESSO
          GestureDetector(
            onTap: () => _navigate(context, '/progresso'),
            child: const Icon(Icons.trending_up, color: Colors.white70, size: 30),
          ),

          const SizedBox(width: 40), // espaço pro botão central

          // CHAT
          GestureDetector(
            onTap: () => _navigate(context, '/chat'),
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white70, size: 30),
          ),

          // PERFIL
          GestureDetector(
            onTap: () => _navigate(context, '/perfil'),
            child: const Icon(Icons.person_outline, color: Colors.white70, size: 30),
          ),
        ],
      ),
    );
  }
}
