import 'package:flutter/material.dart';
import 'package:evolution/model/habit_model.dart';
import 'package:evolution/theme/app_colors.dart';

class HabitDetailsPage extends StatelessWidget {
  final HabitModel habit;

  const HabitDetailsPage({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    // Ordena o histórico para mostrar as datas mais recentes primeiro
    final List<String> history = List.from(habit.completionHistory.reversed);

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo_evolution.png',
          height: 40,
          errorBuilder: (_, __, ___) =>
          const Icon(Icons.rocket_launch, color: AppColors.secondaryPink),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Título
            const Text(
              'Nome do Hábito', // Ou habit.name se quiser dinâmico no topo
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // --- CARD 1: INFO DO HÁBITO ---
            _buildGradientCard(
              child: Row(
                children: [
                  // Círculo Preto (Icone)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A1A1A), // Quase preto
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Nome
                  Expanded(
                    child: Text(
                      habit.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // XP
                  Text(
                    '+${habit.xpValue}XP',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- CARD 2: PROGRESSO XP ---
            _buildGradientCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progresso xp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${(habit.completionHistory.length * habit.xpValue)} XP', // Total XP Acumulado
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Título Dias Consecutivos
            const Text(
              'Dias consecutivos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // --- LISTA DE HISTÓRICO ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                // Gradiente Roxo/Rosa (Vertical)
                gradient: const LinearGradient(
                  colors: [AppColors.secondaryPurple, AppColors.secondaryPink],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: history.isEmpty
                  ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Nenhuma atividade registrada ainda.",
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              )
                  : Column(
                children: history.map((date) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dia $date', // Ex: Dia 2023-10-25
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          '+ ${habit.xpValue} xp',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para os cards gradientes arredondados
  Widget _buildGradientCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.secondaryPurple, AppColors.secondaryPink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30), // Bordas bem arredondadas
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryPink.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}