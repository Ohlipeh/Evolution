import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/progresso_page.dart';
import 'screens/chat_page.dart';
import 'screens/perfil_page.dart';

import 'services/hive_service.dart'; // Importa o novo serviço Hive

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o serviço Hive
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

      // Widget inicial que decide o fluxo
      home: const SplashHandler(),

      // 🔥 TODAS AS ROTAS AQUI!
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/progresso': (context) => const ProgressoPage(),
        '/chat': (context) => const ChatPage(),
        '/perfil': (context) => const PerfilPage(),
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
