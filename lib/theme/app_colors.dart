import 'package:flutter/material.dart';

class AppColors {
  // Base
  static const Color primaryDark = Color(0xFF0F0E27); // fundo principal app

  // Gradiente principal (ROXO → ROSA)
  static const Color secondaryPurple = Color(0xFF4C15A7);
  static const Color secondaryPink = Color(0xFFC700FF);

  // Cards / containers
  static const Color cardLight = Color(0xFFEAEAEA);     // fundo claro do card
  static const Color cardDark = Color(0xFF1A1A35);      // card escuro para dark mode

  // Textos
  static const Color textPrimary = Colors.white;        // texto principal
  static const Color textSecondary = Colors.white70;    // texto secundário
  static const Color textDark = Color(0xFF1A1A1A);      // texto escuro p/ fundo claro

  // Campos de input
  static const Color inputBackground = Color(0x1FFFFFFF); // branco 10%
  static const Color inputBorder = secondaryPink;

  // Outros
  static const Color iconInactive = Colors.white70;
}
