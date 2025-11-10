import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'services/hive_service.dart'; // Importa o novo serviço Hive

// Se você manteve o register_page.dart, pode importá-lo aqui:
// import 'screens/register_page.dart';

void main() async {
  // Garante que os bindings do Flutter estejam prontos
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o serviço Hive
  await HiveService().initializeHive();

  // Inicia a aplicação Flutter
  runApp(const EvolutionApp());
}

class EvolutionApp extends StatelessWidget {
  const EvolutionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evolution App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Tema principal do app
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      // O widget inicial verifica a sessão
      home: const SplashHandler(),
      // Rotas nomeadas
      routes: {
        // Redireciona a rota /login para a nova tela de Setup
        '/login': (context) => const LoginPage(),
        // Se você manteve o register_page.dart, descomente:
        // '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

/// Widget que lida com a verificação inicial de autenticação/setup
class SplashHandler extends StatefulWidget {
  const SplashHandler({super.key});

  @override
  State<SplashHandler> createState() => _SplashHandlerState();
}

class _SplashHandlerState extends State<SplashHandler> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  // Verifica o estado da sessão do Hive e redireciona
  void _redirect() async {
    await Future.delayed(Duration.zero);

    // Verifica se a chave 'isInitialSetupComplete' está marcada como true no Hive
    final isSetupComplete = HiveService().isSetupComplete;

    if (!mounted) return;

    if (!isSetupComplete) {
      // Setup NÃO completo -> Vai para a tela de Configuração do Perfil (LoginPage)
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      // Setup COMPLETO -> Vai para a tela Home
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tela simples de carregamento
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.deepPurple),
            SizedBox(height: 20),
            Text('Carregando a evolução...', style: TextStyle(color: Colors.deepPurple, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}