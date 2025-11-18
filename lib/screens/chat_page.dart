import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_navbar.dart';
import '../theme/app_colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,

      // Drawer igual ao da HomePage
      drawer: const AppDrawer(
        primaryDark: AppColors.primaryDark,
        secondaryPurple: AppColors.secondaryPurple,
        secondaryPink: AppColors.secondaryPink,
      ),

      appBar: AppBar(
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryDark,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: const Center(
        child: Text(
          "Tela de Chat",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),

      // Caso queira o FAB central igual ao da home, só descomentar:
      /*
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
          onPressed: () {},
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
      */

      bottomNavigationBar: const BottomNavBar(
        secondaryPurple: AppColors.secondaryPurple,
        secondaryPink: AppColors.secondaryPink,
        primaryDark: AppColors.primaryDark,
      ),
    );
  }
}
