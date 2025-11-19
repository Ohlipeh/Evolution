import 'package:flutter/material.dart';
import '../services/hive_service.dart';
import '../theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _hiveService = HiveService();

  bool _isLoading = false;

  Future<void> _handleInitialSetup() async {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, digite seu nome para começar.'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _hiveService.saveUserName(name);
      await _hiveService.markSetupComplete();

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/home');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.secondaryPurple,
              AppColors.secondaryPink,
            ],
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryPink.withOpacity(0.4),
              offset: const Offset(0, 4),
              blurRadius: 12,
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: onPressed,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
      // 🔥 Evita bug de teclado empurrar animações
      resizeToAvoidBottomInset: true,

      backgroundColor: AppColors.primaryDark,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0, // 🔥 Fix no Material 3
        title: const Text(
          'Configuração Inicial',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo_evolution.png',
                height: 150,
              ),

              const SizedBox(height: 60),

              // Campo de Nome
              TextField(
                controller: _nameController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Seu Nome ou Nickname',
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  prefixIcon: const Icon(Icons.person,
                      color: AppColors.secondaryPink),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.inputBorder,
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _isLoading
                  ? const CircularProgressIndicator(
                color: AppColors.secondaryPink,
              )
                  : _buildGradientButton(
                text: 'Começar a Evolução',
                onPressed: _handleInitialSetup,
              ),

              const SizedBox(height: 80),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook, color: AppColors.iconInactive),
                  SizedBox(width: 30),
                  Icon(Icons.camera_alt_outlined,
                      color: AppColors.iconInactive),
                  SizedBox(width: 30),
                  Icon(Icons.work_outline, color: AppColors.iconInactive),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
