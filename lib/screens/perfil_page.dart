import 'dart:io'; // Necessário para lidar com arquivo de foto
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Biblioteca de imagem
import 'package:evolution/services/hive_service.dart';
import 'package:evolution/theme/app_colors.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final HiveService _hiveService = HiveService();

  // Variáveis de Estado
  String _userName = "Usuário";
  String? _profileImagePath;
  int _totalXp = 0;
  int _level = 1;
  int _xpCurrentLevel = 0;
  int _xpToNextLevel = 1000; // Meta para subir de nível

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  /// Carrega e calcula todos os dados do usuário baseados no Hive
  void _loadProfileData() {
    // 1. Carregar Nome
    final savedName = _hiveService.getUserName();

    // 2. Carregar Foto (Salva no userBox)
    // Como não criamos método específico no service, acessamos o box direto se possível,
    // ou usamos um método genérico. Vou assumir que podemos salvar no userBox.
    final savedImage = _hiveService.userBox.get('profile_image_path');

    // 3. Calcular XP Total Real
    // Pega todos os hábitos e soma: (Valor do Hábito * Quantas vezes foi feito)
    final habits = _hiveService.getAllHabits();
    int calculatedXp = 0;

    for (var habit in habits) {
      calculatedXp += (habit.xpValue * habit.completionHistory.length);
    }

    // 4. Calcular Nível
    // Exemplo: Nível 1 = 0-999xp, Nível 2 = 1000-1999xp...
    int calculatedLevel = (calculatedXp ~/ 1000) + 1;
    int xpInCurrentLevel = calculatedXp % 1000;

    if (mounted) {
      setState(() {
        _userName = savedName ?? "Usuário";
        _profileImagePath = savedImage;
        _totalXp = calculatedXp;
        _level = calculatedLevel;
        _xpCurrentLevel = xpInCurrentLevel;
      });
    }
  }

  /// Função para escolher nova foto da galeria
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Abre a galeria
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Salva o caminho da imagem no Hive
      await _hiveService.userBox.put('profile_image_path', image.path);

      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Cálculo da porcentagem para a barra (0.0 a 1.0)
    double progressPercent = _xpCurrentLevel / _xpToNextLevel;
    if (progressPercent > 1.0) progressPercent = 1.0;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              /// Nome do usuário
              Text(
                _userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 30),

              /// Avatar com badge lateral (Clicável para trocar foto)
              GestureDetector(
                onTap: _pickImage, // Clica para trocar foto
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.cardDark,
                      backgroundImage: _profileImagePath != null
                          ? FileImage(File(_profileImagePath!))
                          : null,
                      child: _profileImagePath == null
                          ? const Icon(Icons.person, size: 70, color: Colors.white54)
                          : null,
                    ),

                    /// Ícone de câmera para indicar que pode editar
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.secondaryPurple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, size: 16, color: Colors.white),
                      ),
                    ),

                    /// Badge roxa com o level pequeno
                    Positioned(
                      right: -6,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.secondaryPurple,
                              AppColors.secondaryPink
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Text(
                          "Nv. $_level",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// Level principal
              Text(
                "LEVEL $_level",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              /// Barra de XP com gradiente
              Container(
                width: 280,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColors.cardDark, // Fundo da barra vazio
                  border: Border.all(color: Colors.white12, width: 1),
                ),
                child: Stack(
                  children: [
                    // Barra preenchida (Animada)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      width: 280 * progressPercent, // Largura baseada na %
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.secondaryPurple,
                            AppColors.secondaryPink
                          ],
                        ),
                      ),
                    ),

                    // Texto central
                    Center(
                      child: Text(
                        "$_xpCurrentLevel/$_xpToNextLevel",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(offset: Offset(0,1), blurRadius: 2, color: Colors.black45)
                            ]
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// XP total
              Text(
                "$_totalXp XP Total",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 60),

              /// Botão Excluir Conta (Placeholder)
              GestureDetector(
                onTap: () {
                  // Lógica futura para limpar dados
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Função de excluir em breve')),
                  );
                },
                child: const Text(
                  "Excluir Conta",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// Rodapé
              const Text(
                "APK DESENVOLVIDO POR: DART LABS",
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 40), // Espaço extra para bottom bar
            ],
          ),
        ),
      ),
    );
  }
}