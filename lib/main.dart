import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/progresso_page.dart';
import 'screens/motivation_page.dart';
import 'screens/perfil_page.dart'; // Importado

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
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const SplashHandler(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/progresso': (context) => const ProgressoPage(),
        // 🔥 CORREÇÃO DA ROTA: 'motivation'
        '/motivation': (context) => const MotivationPage(),
        '/perfil': (context) => const PerfilPage(),
        // ROTAS ADICIONAIS: Você precisará de uma rota para adicionar hábito
        // Exemplo: '/add_habit': (context) => const AddHabitPage(),
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

  void _redirect() async {
    await Future.delayed(Duration.zero);
    final isSetupComplete = HiveService().isSetupComplete;
    if (!mounted) return;
    if (!isSetupComplete) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
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