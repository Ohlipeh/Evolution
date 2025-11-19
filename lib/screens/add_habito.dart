import 'package:flutter/material.dart';
import 'package:evolution/model/habit_model.dart';
import 'package:evolution/services/hive_service.dart';
import 'package:evolution/theme/app_colors.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController(); // Novo campo: Descrição
  final _xpController = TextEditingController(text: '50'); // XP padrão

  final HiveService _hiveService = HiveService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _xpController.dispose();
    super.dispose();
  }

  /// Função principal para salvar o novo hábito no Hive
  Future<void> _saveHabit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Mapeamento para o HabitModel (usando default 'Diário' para frequency)
      final newHabit = HabitModel.create(
        name: _nameController.text.trim(),
        xpValue: int.tryParse(_xpController.text) ?? 50,
        frequency: "Diário", // Usando um default, pois a UI não coleta frequência
        // NOTA: A Descrição (Descrição Controller) não é salva, pois o HabitModel
        // não possui um campo de 'description'.
      );

      try {
        await _hiveService.createHabit(newHabit);

        // Feedback visual (snackBar) e fecha a tela, retornando 'true'
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Hábito adicionado com sucesso!')),
          );
          Navigator.of(context).pop(true); // Retorna 'true' para atualizar a Home
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao salvar hábito: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  /// Widget auxiliar para campos de input com o estilo Dark e borda arredondada
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.primaryDark, // Usando o fundo Dark para o campo
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

        // Bordas arredondadas e com gradiente (simulado com cor de destaque)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.secondaryPurple, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.secondaryPink, width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 2.5),
        ),
      ),
      validator: validator,
    );
  }

  // Widget para o botão gradiente
  Widget _buildGradientButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [AppColors.secondaryPurple, AppColors.secondaryPink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryPink.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,

      // --- APP BAR CUSTOMIZADA (Baseada no seu design) ---
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              'assets/images/logo_evolution.png', // Logo
              height: 40,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.rocket_launch, color: AppColors.secondaryPink),
            ),
            const SizedBox(height: 5),
            const Text(
              'Adicionar Hábito',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          // Placeholder para o botão de menu (Hamburger)
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),

      // --- CORPO DO FORMULÁRIO ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // 1. Nome do Hábito
              _buildInputField(
                controller: _nameController,
                label: 'Nome do Hábito',
                validator: (value) => (value == null || value.isEmpty) ? 'Obrigatório.' : null,
              ),
              const SizedBox(height: 20),

              // 2. Descrição
              _buildInputField(
                controller: _descriptionController,
                label: 'Descrição (Opcional)',
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),

              // 3. XP Ganho
              _buildInputField(
                controller: _xpController,
                label: 'XP Ganho',
                keyboardType: TextInputType.number,
                validator: (value) => (int.tryParse(value ?? '') == null) ? 'Insira um número.' : null,
              ),
              const SizedBox(height: 50),

              // 4. Botão Salvar
              _buildGradientButton(
                text: 'Salvar',
                onPressed: _saveHabit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}