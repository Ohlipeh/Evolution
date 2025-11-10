import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../model/habit_model.dart'; // Importa o novo modelo

// O nome da caixa (Box) do Hive que usaremos para armazenar dados de configuração e usuário.
const String USER_BOX = 'userBox';
// Chave para rastrear se o usuário completou o setup inicial
const String IS_SETUP_COMPLETE_KEY = 'isInitialSetupComplete';

class HiveService {
  // Singleton Pattern: Garante que haja apenas uma instância do HiveService.
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  // Variáveis para armazenar os Boxes.
  late Box userBox;
  late Box<HabitModel> habitBox; // Box tipado para o modelo HabitModel

  /// ----------------------------------------------------
  /// 1. INICIALIZAÇÃO
  /// ----------------------------------------------------

  /// Inicializa o Hive, registra os adaptadores e abre as caixas (Boxes).
  Future<void> initializeHive() async {
    // 1. Inicializa o Hive no caminho de documentos do dispositivo
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // 2. REGISTRA O ADAPTADOR GERADO
    // Isso é crucial para que o Hive saiba como salvar a classe HabitModel.
    if (!Hive.isAdapterRegistered(HabitModelAdapter().typeId)) {
      Hive.registerAdapter(HabitModelAdapter());
    }

    // 3. Abre os Boxes
    userBox = await Hive.openBox(USER_BOX);
    habitBox = await Hive.openBox<HabitModel>(HabitModel.boxName);
  }

  /// ----------------------------------------------------
  /// 2. CONTROLE DE ESTADO DO SETUP INICIAL
  /// ----------------------------------------------------

  /// Verifica se o setup inicial (cadastro/configuração) já foi completado.
  bool get isSetupComplete {
    return userBox.get(IS_SETUP_COMPLETE_KEY) ?? false;
  }

  /// Marca o setup inicial como completo.
  Future<void> markSetupComplete() async {
    await userBox.put(IS_SETUP_COMPLETE_KEY, true);
  }

  /// Salva o nome de perfil do usuário.
  Future<void> saveUserName(String name) async {
    await userBox.put('userName', name);
  }

  /// Retorna o nome de perfil do usuário.
  String? getUserName() {
    return userBox.get('userName');
  }

  /// ----------------------------------------------------
  /// 3. OPERAÇÕES CRUD DE HÁBITOS
  /// ----------------------------------------------------

  /// Cria um novo hábito no Hive.
  Future<void> createHabit(HabitModel habit) async {
    await habitBox.put(habit.id, habit);
  }

  /// Retorna todos os hábitos.
  List<HabitModel> getAllHabits() {
    // Retorna a lista de todos os valores (objetos HabitModel) no Box.
    return habitBox.values.toList();
  }

  /// Atualiza um hábito (o Hive salva a instância modificada automaticamente).
  Future<void> updateHabit(HabitModel habit) async {
    // O método save() do HiveObject salva a instância no seu Box original.
    await habit.save();
  }

  /// Remove um hábito pelo ID.
  Future<void> deleteHabit(String id) async {
    await habitBox.delete(id);
  }
}