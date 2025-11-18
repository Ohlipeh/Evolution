import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HabitCard extends StatelessWidget {
  final String name;
  final int xp;
  final bool done;
  final VoidCallback onToggle;

  const HabitCard({
    super.key,
    required this.name,
    required this.xp,
    required this.done,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = AppColors.cardLight;                    // card claro
    final Color textColor = done ? AppColors.textSecondary : AppColors.textDark;
    final Color xpColor = done ? AppColors.textSecondary : AppColors.secondaryPink;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Círculo de done
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: done ? AppColors.secondaryPink : AppColors.primaryDark,
                shape: BoxShape.circle,
                boxShadow: done
                    ? [
                  BoxShadow(
                    color: AppColors.secondaryPink.withValues(alpha: 0.45),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  )
                ]
                    : [],
              ),
              child: done
                  ? const Icon(Icons.check, color: Colors.white, size: 20)
                  : null,
            ),
          ),

          const SizedBox(width: 16),

          // Nome do hábito
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                decoration: done ? TextDecoration.lineThrough : null,
              ),
            ),
          ),

          // XP
          Text(
            '+${xp}XP',
            style: TextStyle(
              color: xpColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
