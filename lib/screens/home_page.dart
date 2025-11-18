import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/habit_card.dart';
import '../theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _dummyHabits = [
    {'name': 'Hábito 01', 'xp': 100, 'done': false},
    {'name': 'Hábito 02', 'xp': 50, 'done': false},
    {'name': 'Hábito 03', 'xp': 30, 'done': false},
    {'name': 'Hábito 04', 'xp': 20, 'done': false},
    {'name': 'Hábito 05', 'xp': 10, 'done': false},
  ];

  void _toggleHabit(int index) {
    setState(() {
      _dummyHabits[index]['done'] = !_dummyHabits[index]['done'];
    });
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
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          )
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          const Text(
            'Meus Hábitos',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _dummyHabits.length,
              itemBuilder: (context, index) {
                final habit = _dummyHabits[index];

                return HabitCard(
                  name: habit['name'],
                  xp: habit['xp'],
                  done: habit['done'],
                  onToggle: () => _toggleHabit(index),
                );
              },
            ),
          ),
        ],
      ),

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

      bottomNavigationBar: const BottomNavBar(
        secondaryPurple: AppColors.secondaryPurple,
        secondaryPink: AppColors.secondaryPink,
        primaryDark: AppColors.primaryDark,
      ),
    );
  }
}
