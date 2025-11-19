import 'package:flutter/material.dart';
import 'screens/mainpage.dart';
import 'screens/login_page.dart';
import 'screens/progresso_page.dart';
import 'screens/motivation_page.dart';
import 'screens/perfil_page.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().initializeHive();
  runApp(const EvolutionApp());
}

class EvolutionApp extends StatelessWidget {
  const EvolutionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evolution App',
      debugShowCheckedModeBanner: false,

      // 🔥 Mantém sua paleta e sua identidade
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),

      // Tela inicial dinâmica
      home: const SplashHandler(),

      // 🔥 Rotas centrais da aplicação
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainPage(),
        '/progresso': (context) => const ProgressoPage(),
        '/motivation': (context) => const MotivationPage(),
        '/perfil': (context) => const PerfilPage(),
      },
    );
  }
}

/// SPLASH que decide para onde mandar o usuário
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

  Future<void> _redirect() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final bool isSetupComplete = HiveService().isSetupComplete;

    if (!mounted) return;

    if (!isSetupComplete) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.deepPurple),
            SizedBox(height: 20),
            Text(
              'Carregando a evolução...',
              style: TextStyle(color: Colors.deepPurple, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
