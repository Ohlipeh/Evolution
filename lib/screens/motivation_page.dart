import 'package:flutter/material.dart';
import 'package:evolution/services/gemini_service.dart';
import 'package:evolution/theme/app_colors.dart';

class MotivationPage extends StatefulWidget {
  const MotivationPage({super.key});

  @override
  State<MotivationPage> createState() => _MotivationPageState();
}

class _MotivationPageState extends State<MotivationPage> {
  final GeminiService _geminiService = GeminiService();
  String _quote = 'Gerando inspiração...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  /// Busca frase motivacional
  Future<void> _fetchQuote() async {
    setState(() {
      _isLoading = true;
      _quote = 'Gerando inspiração...';
    });

    final quote = await _geminiService.generateMotivationalQuote();

    setState(() {
      _quote = quote;
      _isLoading = false;
    });
  }

  /// Botão gradient
  Widget _buildGradientButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [AppColors.secondaryPurple, AppColors.secondaryPink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryPink.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: _isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
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

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Frase motivacional com UI mais bonita
              AnimatedOpacity(
                opacity: _isLoading ? 0.4 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _quote.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 60),

              // Botão de gerar frase
              _buildGradientButton(
                text: 'Gerar Frase',
                onPressed: _fetchQuote,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
