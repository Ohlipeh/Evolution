import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_navbar.dart';

// Telas
import 'home_page.dart';
import 'progresso_page.dart';
import 'motivation_page.dart';
import 'perfil_page.dart';
import 'add_habito.dart';

class ApkPage extends StatefulWidget {
  const ApkPage({super.key});

  @override
  State<ApkPage> createState() => _ApkPageState();
}

class _ApkPageState extends State<ApkPage> {
  int _currentIndex = 0;

  final _pages = const [
    HomePage(),
    ProgressoPage(),
    MotivationPage(),
    PerfilPage(),
  ];

  void _onAddHabit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddHabitPage()),
    );
  }

  void _onTabSelected(int index) {
    if (index == 2) return; // botão central "+"
    setState(() => _currentIndex = index);
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
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo_evolution.png',
          height: 40,
          errorBuilder: (_, __, ___) =>
          const Icon(Icons.rocket_launch, color: AppColors.secondaryPink),
        ),
      ),

      body: _pages[_currentIndex],

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
          onPressed: _onAddHabit,
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),

      bottomNavigationBar: BottomNavBar(
        primaryDark: AppColors.primaryDark,
        secondaryPink: AppColors.secondaryPink,
        secondaryPurple: AppColors.secondaryPurple,
        onTabSelected: _onTabSelected,
        currentIndex: _currentIndex,
      ),
    );
  }
}
