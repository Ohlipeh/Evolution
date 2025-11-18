import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // --- CORES DO DESIGN ---
  static const Color primaryDark = Color(0xFF0F0E27);
  static const Color cardBackground = Color(0xFFEAEAEA);
  static const Color secondaryPurple = Color(0xFF4C15A7);
  static const Color secondaryPink = Color(0xFFC700FF);

  // --- DADOS FICTÍCIOS ---
  final List<Map<String, dynamic>> _dummyHabits = [
    {'name': 'Hábito 01', 'xp': 100, 'done': false},
    {'name': 'Hábito 02', 'xp': 50, 'done': false},
    {'name': 'Hábito 03', 'xp': 30, 'done': false},
    {'name': 'Hábito 04', 'xp': 20, 'done': false},
    {'name': 'Hábito 05', 'xp': 10, 'done': false},
  ];

  // Alternar hábito
  void _toggleHabit(int index) {
    setState(() {
      _dummyHabits[index]['done'] = !_dummyHabits[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,

      // ============================
      //      DRAWER EXTERNO
      // ============================
      drawer: const AppDrawer(
        primaryDark: primaryDark,
        secondaryPurple: secondaryPurple,
        secondaryPink: secondaryPink,
      ),

      // ============================
      //           APP BAR
      // ============================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo_evolution.png',
          height: 40,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.rocket_launch, color: secondaryPink),
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

      // ============================
      //            CORPO
      // ============================
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          const Center(
            child: Text(
              'Meus Hábitos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _dummyHabits.length,
              itemBuilder: (context, index) {
                final habit = _dummyHabits[index];
                final bool isDone = habit['done'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: cardBackground,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.20),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // --- CÍRCULO CHECKBOX ---
                      GestureDetector(
                        onTap: () => _toggleHabit(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isDone ? secondaryPink : primaryDark,
                            shape: BoxShape.circle,
                            boxShadow: isDone
                                ? [
                              BoxShadow(
                                color: secondaryPink
                                    .withValues(alpha: 0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ]
                                : [],
                          ),
                          child: isDone
                              ? const Icon(Icons.check,
                              color: Colors.white, size: 20)
                              : null,
                        ),
                      ),

                      const SizedBox(width: 16),

                      // --- NOME DO HÁBITO ---
                      Text(
                        habit['name'],
                        style: TextStyle(
                          color: isDone ? Colors.grey : primaryDark,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),

                      const Spacer(),

                      // --- XP ---
                      Text(
                        '+${habit['xp']}XP',
                        style: TextStyle(
                          color: isDone ? Colors.grey : secondaryPink,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // ============================
      //            BOTÃO + FAB
      // ============================
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryDark, width: 8),
        ),
        child: FloatingActionButton(
          backgroundColor: primaryDark,
          elevation: 0,
          onPressed: () {},
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),

      // ============================
      //     NAVBAR EXTERNA
      // ============================
      bottomNavigationBar: const BottomNavBar(
        secondaryPurple: secondaryPurple,
        secondaryPink: secondaryPink,
        primaryDark: primaryDark,
      ),
    );
  }
}
