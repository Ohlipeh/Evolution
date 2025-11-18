import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:evolution/theme/app_colors.dart'; // Importando o AppColors

class ProgressoPage extends StatefulWidget {
  const ProgressoPage({super.key});

  // Nome da classe State deve corresponder à classe do Widget
  @override
  State<ProgressoPage> createState() => _ProgressoPageState();
}

class _ProgressoPageState extends State<ProgressoPage> {
  // Cores agora referenciadas via AppColors
  final Color primaryDark = AppColors.primaryDark;
  final Color secondaryPurple = AppColors.secondaryPurple;
  final Color secondaryPink = AppColors.secondaryPink;
  final Color cardBackground = AppColors.cardLight;

  // Dados do Gráfico (XP ganho nos últimos 7 dias)
  final List<double> weeklyActivity = [5, 10, 8, 4, 12, 7, 9];

  // Conquistas (Ícones universais do Material Design)
  final List<Map<String, dynamic>> trophies = [
    {'name': 'Iniciante', 'unlocked': true, 'icon': Icons.star},
    {'name': 'Focado', 'unlocked': true, 'icon': Icons.local_fire_department},
    {'name': 'Mestre', 'unlocked': false, 'icon': Icons.verified},
    {'name': 'Lendário', 'unlocked': false, 'icon': Icons.shield},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Ícone de voltar (seta) e menu com cores brancas
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Seu Progresso', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- GRÁFICO SEMANAL ---
            const Text(
              'Atividade Semanal',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // Fundo translúcido para o gráfico
                color: cardBackground.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 15,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
                          if (value.toInt() >= 0 && value.toInt() < days.length) {
                            return Text(days[value.toInt()], style: const TextStyle(color: Colors.white));
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  barGroups: weeklyActivity.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          color: secondaryPink, // Cor lilás do tema
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- SEÇÃO DE CONQUISTAS (TROFÉUS) ---
            const Text(
              'Conquistas',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trophies.length,
                itemBuilder: (context, index) {
                  final trophy = trophies[index];
                  final bool unlocked = trophy['unlocked'];
                  return Container(
                    margin: const EdgeInsets.only(right: 15),
                    width: 80,
                    decoration: BoxDecoration(
                      color: unlocked ? secondaryPurple.withOpacity(0.5) : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      border: unlocked ? Border.all(color: secondaryPink, width: 2) : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          trophy['icon'] as IconData,
                          color: unlocked ? Colors.amber : Colors.grey,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          trophy['name'] as String,
                          style: TextStyle(
                            color: unlocked ? Colors.white : Colors.white54,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            // --- SEÇÃO DE HISTÓRICO RECENTE ---
            const Text(
              'Histórico Recente',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // Exemplo estático de lista
            ...List.generate(3, (index) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: cardBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryDark,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: secondaryPink, size: 16),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hábito ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      Text('Hoje, ${index + 1} PM', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Text('+50 XP', style: TextStyle(color: secondaryPurple, fontWeight: FontWeight.bold)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}