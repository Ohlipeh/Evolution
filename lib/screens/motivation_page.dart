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

  /// Busca a frase motivacional usando o serviço Gemini
  Future<void> _fetchQuote() async {
    setState(() {
      _isLoading = true;
      _quote = 'Gerando inspiração...';
    });

    final quote = await _geminiService.generateMotivationalQuote();

    // Atualiza o estado da tela
    setState(() {
      _quote = quote;
      _isLoading = false;
    });
  }

  // Widget para o botão gradiente (reutilizado do login)
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
            color: AppColors.secondaryPink.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : onPressed, // Desabilita o botão enquanto carrega
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: _isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Texto da Frase Motivacional
              Text(
                _quote.toUpperCase(), // Frase em CAIXA ALTA
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // Botão Gerar Frase
              _buildGradientButton(
                text: 'Gerar Frase',
                onPressed: _fetchQuote,
              ),
            ],
          ),
        ),
      ),
      // Não incluímos a BottomNavBar aqui para evitar duplicidade,
      // mas ela será incluída pela HomePage se for a estrutura de abas
    );
  }
}