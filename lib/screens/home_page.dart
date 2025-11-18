import 'package:flutter/material.dart';
// import '../services/hive_service.dart'; // Descomente quando for usar dados reais
// import '../model/habit_model.dart';    // Descomente quando for usar dados reais

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
  static const Color secondaryPink = Color(0xFFC700FF); // O Lilás/Rosa vibrante

  // --- DADOS FICTÍCIOS (Estado Local) ---
  final List<Map<String, dynamic>> _dummyHabits = [
    {'name': 'Hábito 01', 'xp': 100, 'done': false},
    {'name': 'Hábito 02', 'xp': 50, 'done': false},
    {'name': 'Hábito 03', 'xp': 30, 'done': false},
    {'name': 'Hábito 04', 'xp': 20, 'done': false},
    {'name': 'Hábito 05', 'xp': 10, 'done': false},
  ];

  // Função para alternar o estado do hábito
  void _toggleHabit(int index) {
    setState(() {
      _dummyHabits[index]['done'] = !_dummyHabits[index]['done'];

      // Futuramente: Aqui você chamará o HiveService para salvar no banco de dados
      // e somar o XP ao usuário!
      if (_dummyHabits[index]['done']) {
        print("Ganhou ${_dummyHabits[index]['xp']} XP!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,

      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context);
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
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      // --- CORPO ---
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

                // Destaque azul apenas para o primeiro item (opcional, conforme seu design)
                final bool isFirst = index == 0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: cardBackground,
                    borderRadius: BorderRadius.circular(30),
                    // Borda azul se for o primeiro E não estiver feito (opcional)
                    border: (isFirst && !isDone)
                        ? Border.all(color: Colors.blueAccent, width: 2)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      // --- CHECKBOX CUSTOMIZADO (CÍRCULO) ---
                      GestureDetector(
                        onTap: () => _toggleHabit(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300), // Animação suave
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            // Se feito: cor Lilás (Pink). Se não: Azul Escuro
                            color: isDone ? secondaryPink : primaryDark,
                            shape: BoxShape.circle,
                            boxShadow: isDone ? [
                              BoxShadow(
                                color: secondaryPink.withOpacity(0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ] : [],
                          ),
                          child: isDone
                              ? const Icon(Icons.check, color: Colors.white, size: 20)
                              : null,
                        ),
                      ),

                      const SizedBox(width: 16),

                      // --- NOME DO HÁBITO ---
                      Text(
                        habit['name'],
                        style: TextStyle(
                          color: isDone ? Colors.grey : primaryDark, // Fica cinza se feito
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          decoration: isDone ? TextDecoration.lineThrough : null, // Risca o texto se feito
                        ),
                      ),

                      const Spacer(),

                      // --- VALOR DE XP ---
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

      // --- BOTÃO FLUTUANTE (FAB) ---
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: primaryDark, width: 8),
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Ação para adicionar
          },
          backgroundColor: primaryDark,
          elevation: 0,
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),

      // --- BARRA DE NAVEGAÇÃO ---
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [secondaryPurple, secondaryPink],
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
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white, size: 30),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.trending_up, color: Colors.white70, size: 30),
              onPressed: () {},
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.white70, size: 30),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person_outline, color: Colors.white70, size: 30),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}