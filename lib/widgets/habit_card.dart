import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HabitCard extends StatelessWidget {
  final String name;
  final int xp;
  final bool done;
  final VoidCallback onToggle;
  final VoidCallback onTap;
  final VoidCallback onDelete; // 🔥 NOVO: callback da lixeira

  const HabitCard({
    super.key,
    required this.name,
    required this.xp,
    required this.done,
    required this.onToggle,
    required this.onTap,
    required this.onDelete, // 🔥 OBRIGATÓRIO AGORA
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // abre detalhes
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.cardLight,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            // ---------------- CHECKBOX ----------------
            GestureDetector(
              onTap: onToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: done ? AppColors.secondaryPink : AppColors.primaryDark,
                  shape: BoxShape.circle,
                ),
                child: done
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : null,
              ),
            ),

            const SizedBox(width: 16),

            // ---------------- TÍTULO ----------------
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: done ? Colors.grey : AppColors.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  decoration: done ? TextDecoration.lineThrough : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // ---------------- XP ----------------
            Text(
              '+${xp}XP',
              style: TextStyle(
                color: done ? Colors.grey : AppColors.secondaryPink,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 12),

            // ---------------- LIXEIRA ----------------
            GestureDetector(
              onTap: () {
                // Evita clicar no card ao tocar na lixeira
                onDelete();
              },
              child: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
