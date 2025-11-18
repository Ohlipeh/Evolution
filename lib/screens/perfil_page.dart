import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_navbar.dart';
import '../theme/app_colors.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,

      // Drawer igual às outras telas
      drawer: const AppDrawer(
        primaryDark: AppColors.primaryDark,
        secondaryPurple: AppColors.secondaryPurple,
        secondaryPink: AppColors.secondaryPink,
      ),

      appBar: AppBar(
        title: const Text(
          "Meu Perfil",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryDark,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: const Center(
        child: Text(
          "Tela de Perfil",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),

      bottomNavigationBar: const BottomNavBar(
        secondaryPurple: AppColors.secondaryPurple,
        secondaryPink: AppColors.secondaryPink,
        primaryDark: AppColors.primaryDark,
      ),
    );
  }
}
