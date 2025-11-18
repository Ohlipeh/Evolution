import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Cores do Design
  static const Color primaryDark = Color(0xFF0F0E27);
  static const Color secondaryPurple = Color(0xFF4C15A7);
  static const Color secondaryPink = Color(0xFFC700FF);
  static const Color cardBackground = Color(0xFFEAEAEA);

  // Dados do Gráfico (XP ganho nos últimos 7 dias)
  final List<double> weeklyActivity = [5, 10, 8, 4, 12, 7, 9];

  // Conquistas (Ícones universais do Material Design)
  final List<Map<String, dynamic>> trophies = [
    {'name': 'Iniciante', 'unlocked': true, 'icon': Icons.star}, // Estrela
    {'name': 'Focado', 'unlocked': true, 'icon': Icons.local_fire_department}, // Fogo
    {'name': 'Mestre', 'unlocked': false, 'icon': Icons.verified}, // Verificado
    {'name': 'Lendário', 'unlocked': false, 'icon': Icons.shield}, // Escudo
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // Garante a seta branca
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
                color: cardBackground.withOpacity(0.1), // Fundo translúcido
                borderRadius: BorderRadius.circular(20),
              ),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 15, // Valor máximo
                  barTouchData: BarTouchData(enabled: false), // Desativa interação de toque
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S']; // Dias da semana
                          if (value.toInt() >= 0 && value.toInt() < days.length) {
                            return Text(days[value.toInt()], style: const TextStyle(color: Colors.white));
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    // Esconde todos os outros títulos para um visual limpo
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
                          color: secondaryPink, // Cor lilás
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
                      color: unlocked ? secondaryPurple.withOpacity(0.5) : Colors.grey.withOpacity(0.2), // Fundo
                      borderRadius: BorderRadius.circular(15),
                      border: unlocked ? Border.all(color: secondaryPink, width: 2) : null, // Borda se desbloqueado
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          trophy['icon'] as IconData, // Usa o ícone da lista
                          color: unlocked ? Colors.amber : Colors.grey, // Dourado se desbloqueado
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
            // Exemplo estático de lista (Deve ser substituído por dados do Hive)
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
                    decoration: const BoxDecoration(
                      color: primaryDark,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: secondaryPink, size: 16),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hábito ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: primaryDark)),
                      Text('Hoje, ${index + 1} PM', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  const Text('+50 XP', style: TextStyle(color: secondaryPurple, fontWeight: FontWeight.bold)),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}