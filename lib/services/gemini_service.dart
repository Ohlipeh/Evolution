import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

// --- ATENÇÃO ---
// Substitua este valor vazio pela sua chave de API do Gemini
const String GEMINI_API_KEY = '';
// --- ATENÇÃO ---

class GeminiService {
  // Configuração padrão do modelo (SEM 'const' para evitar erro de sintaxe)
  final GenerationConfig _config = GenerationConfig(
    temperature: 1.0, // Máxima criatividade para forçar variação
    maxOutputTokens: 256,
  );

  // A variável 'isInitialized' verifica se a chave foi fornecida.
  final bool isInitialized = GEMINI_API_KEY.isNotEmpty;

  GeminiService();

  /// Gera uma frase motivacional aleatória.
  ///
  /// Esta função inicializa o modelo internamente em cada chamada para garantir
  /// que a IA não use cache e gere conteúdo realmente novo.
  Future<String> generateMotivationalQuote() async {
    if (!isInitialized) {
      return 'Configure sua API Key para receber frases do universo!';
    }

    try {
      // 1. Inicializa o modelo usando o gemini-2.5-flash
      final GenerativeModel model = GenerativeModel(
        model: 'gemini-2.5-flash-preview-09-2025',
        apiKey: GEMINI_API_KEY,
        generationConfig: _config,
      );

      // 2. Usando um valor randômico para mudar o prompt (resolve a repetição)
      final uniqueFactor = DateTime.now().microsecondsSinceEpoch % 1000;

      // Prompt com a instrução de ser diferente e o fator de aleatoriedade
      final prompt = 'Gere uma frase motivacional ÚNICA, inspiradora e poderosa (máximo 20 palavras) sobre evolução pessoal e hábitos. Certifique-se de que a frase seja diferente da anterior. Retorne apenas o texto da frase, sem aspas e sem autoria. Fator Aleatório: $uniqueFactor';

      // 3. Chamada da API
      final response = await model.generateContent([
        Content.text(prompt)
      ]);

      return response.text?.trim() ?? 'O progresso é impossível sem mudança.';

    } catch (e) {
      if (kDebugMode) {
        print('Erro ao chamar API Gemini: $e');
      }
      return 'A persistência é o caminho do êxito.';
    }
  }
}