import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProgressoPage extends StatelessWidget {
  const ProgressoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        title: const Text("Progresso", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryDark,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Tela de Progresso",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}

