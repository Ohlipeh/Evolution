import 'package:hive_flutter/hive_flutter.dart';

// Importa o arquivo gerado. Ele ainda não existe, mas será criado
// quando você rodar o build_runner.
part 'habit_model.g.dart';

// -------------------------------------------------------------------
// 1. MODELO DE HÁBITO
// -------------------------------------------------------------------

// Anotação obrigatória para o Hive, com um TypeId único.
@HiveType(typeId: 0)
class HabitModel extends HiveObject {
  // O nome do Box (Caixa) onde os hábitos serão armazenados.
  static const String boxName = 'habitBox';

  // 1. Informações Básicas
  @HiveField(0)
  late String id; // ID único para o hábito

  @HiveField(1)
  late String name; // Nome do Hábito (ex: "Ler 30 minutos")

  // 2. Gamificação
  @HiveField(2)
  late int xpValue; // XP ganho ao completar o hábito (ex: 50 XP)

  @HiveField(3)
  late int level; // Nível de maestria do hábito (pode começar em 1)

  // 3. Frequência e Rastreamento
  @HiveField(4)
  late String frequency; // Frequência (ex: 'Diário', 'Semanal', 'Seg, Qua, Sex')

  // Lista de datas (apenas o dia) em que o hábito foi completado.
  // Usaremos String no formato 'YYYY-MM-DD' para fácil armazenamento no Hive.
  @HiveField(5)
  late List<String> completionHistory;

  // Construtor
  HabitModel({
    required this.id,
    required this.name,
    this.xpValue = 50, // Valor padrão de XP
    this.level = 1,    // Nível inicial
    this.frequency = 'Diário',
    this.completionHistory = const [],
  });

  // Método de conveniência para criar um ID
  HabitModel.create({
    required this.name,
    this.xpValue = 50,
    this.level = 1,
    this.frequency = 'Diário',
    this.completionHistory = const [],
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();
}