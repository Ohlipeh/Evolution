import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/habit_card.dart';
import '../theme/app_colors.dart';
import 'package:evolution/services/hive_service.dart';
import 'package:evolution/model/habit_model.dart';

import 'add_habito.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HiveService _hiveService = HiveService();
  List<HabitModel> _habits = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  /// Carrega a lista de hábitos do banco de dados local
  void _loadHabits() {
    setState(() {
      _habits = _hiveService.getAllHabits();
      // Inverte a lista para os novos aparecerem no topo (opcional)
      _habits = _habits.reversed.toList();
      _isLoading = false;
    });
  }

  /// Marca ou desmarca um hábito
  void _toggleHabit(HabitModel habit) async {
    final today = DateTime.now().toString().substring(0, 10); // Data YYYY-MM-DD

    setState(() {
      if (habit.completionHistory.contains(today)) {
        habit.completionHistory.remove(today);
      } else {
        habit.completionHistory.add(today);
      }
    });

    // Salva no Hive
    await _hiveService.updateHabit(habit);
    // Recarrega para garantir consistência
    _loadHabits();
  }

  /// Navega para a tela de adicionar hábito (Modal)
  void _navigateToAddHabit() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddHabitPage(),
        fullscreenDialog: true, // Abre como um modal de tela cheia
      ),
    );

    // Se a tela retornar 'true', significa que salvou algo novo, então recarrega
    if (result == true) {
      _loadHabits();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,

      // Menu Lateral
      drawer: const AppDrawer(
        primaryDark: AppColors.primaryDark,
        secondaryPurple: AppColors.secondaryPurple,
        secondaryPink: AppColors.secondaryPink,
      ),

      // Topo
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

      // Lista de Hábitos
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.secondaryPink))
                : _habits.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.post_add, size: 60, color: AppColors.textSecondary.withOpacity(0.5)),
                  const SizedBox(height: 10),
                  Text(
                    'Nenhum hábito ainda.\nClique no "+" para evoluir!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100), // Espaço extra embaixo
              itemCount: _habits.length,
              itemBuilder: (context, index) {
                final habit = _habits[index];
                final today = DateTime.now().toString().substring(0, 10);
                final isDone = habit.completionHistory.contains(today);

                return HabitCard(
                  name: habit.name,
                  xp: habit.xpValue,
                  done: isDone,
                  onToggle: () => _toggleHabit(habit),
                );
              },
            ),
          ),
        ],
      ),

      // Botão Flutuante Central (+)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryDark, width: 8), // Borda grossa para separar da barra
        ),
        child: FloatingActionButton(
          backgroundColor: AppColors.secondaryPurple,
          elevation: 5,
          onPressed: _navigateToAddHabit, // Conecta ao modal de adicionar
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),

      // Barra de Navegação
      bottomNavigationBar: const BottomNavBar(
        secondaryPurple: AppColors.secondaryPurple,
        secondaryPink: AppColors.secondaryPink,
        primaryDark: AppColors.primaryDark,
      ),
    );
  }
}