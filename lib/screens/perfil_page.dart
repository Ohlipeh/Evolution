import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_navbar.dart';
import '../theme/app_colors.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  // Função de navegação para Adicionar Hábito
  void _navigateToAddHabit(BuildContext context) {
    // Aqui você navegaria para a rota que irá criar: '/add_habit'
    // Exemplo: Navigator.pushNamed(context, '/add_habit');
    print('Abrir tela de Adicionar Hábito');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,

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

      // --- FAB (Floating Action Button) ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryDark, width: 8),
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.secondaryPurple,
          elevation: 0,
          onPressed: () => _navigateToAddHabit(context), // CONEXÃO FAB
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),

      // --- BOTTOM NAV BAR CONECTADA ---
      bottomNavigationBar: BottomNavBar(
        secondaryPurple: AppColors.secondaryPurple,
        secondaryPink: AppColors.secondaryPink,
        primaryDark: AppColors.primaryDark,
        // Conecta o FAB da navbar ao mesmo método
        onAddPressed: () => _navigateToAddHabit(context),
      ),
    );
  }
}