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
  final _descriptionController = TextEditingController();
  final _xpController = TextEditingController(text: '50');

  final HiveService _hiveService = HiveService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _xpController.dispose();
    super.dispose();
  }

  Future<void> _saveHabit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final newHabit = HabitModel.create(
        name: _nameController.text.trim(),
        xpValue: int.tryParse(_xpController.text) ?? 50,
        frequency: "Diário",
      );

      try {
        await _hiveService.createHabit(newHabit);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Hábito adicionado com sucesso!')),
          );
          Navigator.of(context).pop(true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao salvar hábito: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

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
        fillColor: AppColors.primaryDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.secondaryPurple, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.secondaryPink, width: 2.5),
        ),
      ),
      validator: validator,
    );
  }

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

      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Column(
          children: [
            Image.asset(
              'assets/images/logo_evolution.png',
              height: 38,
            ),
            const SizedBox(height: 4),
            const Text(
              'Adicionar Hábito',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        toolbarHeight: 80, // 🔥 Corrige o corte da AppBar
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500), // 🔥 CENTRALIZA E LIMITA O TAMANHO
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInputField(
                    controller: _nameController,
                    label: 'Nome do Hábito',
                    validator: (value) =>
                    (value == null || value.isEmpty) ? 'Obrigatório.' : null,
                  ),
                  const SizedBox(height: 20),

                  _buildInputField(
                    controller: _descriptionController,
                    label: 'Descrição (Opcional)',
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 20),

                  _buildInputField(
                    controller: _xpController,
                    label: 'XP Ganho',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                    (int.tryParse(value ?? '') == null) ? 'Insira um número.' : null,
                  ),
                  const SizedBox(height: 40),

                  _buildGradientButton(
                    text: 'Salvar',
                    onPressed: _saveHabit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
