import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import 'home_page.dart';
import 'progresso_page.dart';
import 'motivation_page.dart';
import 'perfil_page.dart';
import 'add_habito.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ProgressoPage(),
    MotivationPage(),
    PerfilPage(),
  ];

  void _openAddHabit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddHabitPage(),
        fullscreenDialog: true,
      ),
    );

    if (result == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,

      // -------------------- END DRAWER --------------------
      endDrawer: Drawer(
        backgroundColor: AppColors.primaryDark,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondaryPurple,
                    AppColors.secondaryPink
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Evolution XP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bem-vindo(a)!',
                    style: TextStyle(color: Colors.white70),
                  )
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Início', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              },
            ),

            ListTile(
              leading: const Icon(Icons.trending_up, color: Colors.white),
              title: const Text('Progresso', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1);
              },
            ),

            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text('Perfil', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                setState(() => _currentIndex = 3);
              },
            ),

            const Divider(color: Colors.white24),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Sair', style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),

      // -------------------- APPBAR --------------------
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo_evolution.png',
          height: 40,
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),

      // -------------------- SAFE AREA --------------------
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: paddingBottom),
          child: _pages[_currentIndex],
        ),
      ),

      // -------------------- FLOATING BUTTON (PERFEITO) --------------------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white24,
            width: 2,
          ),
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryDark,
          elevation: 0,
          highlightElevation: 0,
          splashColor: Colors.transparent,
          shape: const CircleBorder(),
          onPressed: _openAddHabit,
          child: const Icon(
            Icons.add,
            size: 34,
            color: Colors.white,
          ),
        ),
      ),

      // -------------------- BOTTOM NAV BAR --------------------
      bottomNavigationBar: _buildBottomNavBar(paddingBottom),
    );
  }

  Widget _buildBottomNavBar(double paddingBottom) {
    return Container(
      height: 80 + paddingBottom,
      padding: EdgeInsets.only(bottom: paddingBottom),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondaryPurple, AppColors.secondaryPink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(Icons.home, 0),
          _item(Icons.trending_up, 1),
          const SizedBox(width: 40), // espaço para o FAB
          _item(Icons.chat_bubble_outline, 2),
          _item(Icons.person_outline, 3),
        ],
      ),
    );
  }

  Widget _item(IconData icon, int index) {
    final bool selected = index == _currentIndex;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Icon(
            icon,
            size: 30,
            color: selected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}
