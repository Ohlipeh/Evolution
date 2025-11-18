import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        title: const Text("Meu Perfil", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryDark,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Tela de Perfil",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
