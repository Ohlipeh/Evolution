import 'package:flutter/material.dart';
import '../widgets/habit_card.dart';
import '../theme/app_colors.dart';
import 'package:evolution/services/hive_service.dart';
import 'package:evolution/model/habit_model.dart';

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

  /// Carrega hábitos
  void _loadHabits() {
    setState(() {
      _habits = _hiveService.getAllHabits().reversed.toList();
      _isLoading = false;
    });
  }

  /// Marca ou desmarca hábito
  void _toggleHabit(HabitModel habit) async {
    final today = DateTime.now().toString().substring(0, 10);

    setState(() {
      if (habit.completionHistory.contains(today)) {
        habit.completionHistory.remove(today);
      } else {
        habit.completionHistory.add(today);
      }
    });

    await _hiveService.updateHabit(habit);
    _loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,

      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 10, // Remove altura do appbar (ficamos só com statusbar)
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),

            // Título principal
            const Text(
              'Meus Hábitos',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: _isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondaryPink,
                ),
              )
                  : _habits.isEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 70,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Nenhum hábito ainda.\nClique no "+" para evoluir!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
                  : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: _habits.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final habit = _habits[index];
                  final today =
                  DateTime.now().toString().substring(0, 10);
                  final isDone =
                  habit.completionHistory.contains(today);

                  return HabitCard(
                    name: habit.name,
                    xp: habit.xpValue,
                    done: isDone,
                    onToggle: () => _toggleHabit(habit), onTap: () {  },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
