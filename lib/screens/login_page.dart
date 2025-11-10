import 'package:flutter/material.dart';
import '../services/hive_service.dart';

// Esta tela não é mais um "Login", mas sim a "Configuração Inicial do Perfil"
// para o banco de dados local (Hive).
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para o campo de texto
  final _nameController = TextEditingController();
  // Instância do nosso serviço de banco de dados
  final _hiveService = HiveService();
  bool _isLoading = false;

  // --- Paleta de Cores do Design ---
  // Cor principal do fundo (Azul escuro/preto)
  static const Color primaryDark = Color(0xFF0F0E27);
  // Cores do gradiente (Roxo e Rosa)
  static const Color secondaryPurple = Color(0xFF4C15A7);
  static const Color secondaryPink = Color(0xFFC700FF);

  /// Lógica para lidar com a configuração inicial
  Future<void> _handleInitialSetup() async {
    // Validação simples para garantir que o nome não está vazio
    if (_nameController.text.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, digite seu nome para começar.')),
        );
      }
      return;
    }

    setState(() {
      _isLoading = true; // Ativa o indicador de carregamento
    });

    try {
      // 1. Salva o nome do usuário no Hive
      await _hiveService.saveUserName(_nameController.text.trim());

      // 2. Marca a configuração inicial como completa no Hive
      await _hiveService.markSetupComplete();

      // Navegação para a Home Page após sucesso
      if (mounted) {
        // Usa pushReplacementNamed para limpar a pilha e ir para a rota nomeada '/home'
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      // Em caso de erro
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar configuração: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false; // Desativa o indicador de carregamento
      });
    }
  }

  /// Widget reutilizável para criar o botão gradiente (estilo do seu design)
  Widget _buildGradientButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25), // Borda arredondada
        gradient: const LinearGradient(
          colors: [secondaryPurple, secondaryPink], // O gradiente do design
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [ // Sombra para dar profundidade
          BoxShadow(
            color: secondaryPink.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell( // Efeito de clique (ripple)
          onTap: onPressed,
          borderRadius: BorderRadius.circular(25),
          child: Center(
            child: Text(
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
      backgroundColor: primaryDark, // Fundo escuro (conforme design)
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparente para integrar ao fundo
        elevation: 0,
        title: const Text(
            'Configuração Inicial',
            style: TextStyle(color: Colors.white70)),
      ),
      body: Center(
        child: SingleChildScrollView( // Permite rolagem se a tela for pequena
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // --- Placeholder para o Logo de Astronauta ---
              // --- Logo Oficial do App ---
              // Certifique-se de que o caminho 'assets/images/logo_evolution.png' está correto.
              Image.asset(
                'assets/images/logo_evolution.png',
                // Ajuste a altura para um tamanho adequado ao seu design.
                height: 150,
              ),
              const SizedBox(height: 60),

              // --- Campo Nome (Estilo adaptado para o tema escuro) ---
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                style: const TextStyle(color: Colors.white), // Texto digitado em branco
                decoration: InputDecoration(
                  labelText: 'Seu Nome ou Nickname',
                  labelStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1), // Fundo do campo
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none, // Sem borda padrão
                  ),
                  focusedBorder: OutlineInputBorder( // Borda ao focar
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: secondaryPink, width: 2),
                  ),
                  prefixIcon: const Icon(Icons.person, color: secondaryPink),
                ),
              ),
              const SizedBox(height: 30),

              // --- Botão Principal (Estilizado) ---
              // Mostra o loading ou o botão
              _isLoading
                  ? const CircularProgressIndicator(color: secondaryPink)
                  : _buildGradientButton(
                text: 'Começar a Evolução',
                onPressed: _handleInitialSetup, // Chama a lógica do Hive
              ),

              const SizedBox(height: 100), // Espaço antes dos ícones

              // --- Ícones Sociais (Substituídos por Nativos) ---
              // Usamos ícones nativos para evitar o erro de compilação.
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ícone nativo do Facebook
                  Icon(Icons.facebook, size: 30, color: Colors.white70),
                  SizedBox(width: 30),
                  // Substituto nativo para Instagram
                  Icon(Icons.camera_alt_outlined, size: 30, color: Colors.white70),
                  SizedBox(width: 30),
                  // Substituto nativo para LinkedIn
                  Icon(Icons.work_outline, size: 30, color: Colors.white70),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}