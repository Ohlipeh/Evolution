import 'package:supabase_flutter/supabase_flutter.dart';

// Variáveis de ambiente: Em um projeto real, você usaria variáveis de ambiente
// ou um arquivo .env. Use seus valores reais aqui.
const SUPABASE_URL = 'SUA_URL_SUPABASE_AQUI'; // Exemplo: 'https://xyz.supabase.co'
const SUPABASE_ANON_KEY = 'SUA_CHAVE_ANON_AQUI';

class SupabaseService {
  // Singleton Pattern: Garante que haja apenas uma instância do SupabaseService.
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  // Cliente Supabase que será usado em todo o aplicativo.
  final SupabaseClient client = Supabase.instance.client;

  // ----------------------------------------------------
  // 1. INICIALIZAÇÃO
  // ----------------------------------------------------

  /// Inicializa o Supabase no início do seu aplicativo (geralmente no main()).
  Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: SUPABASE_URL,
      anonKey: SUPABASE_ANON_KEY,
    );
  }

  // ----------------------------------------------------
  // 2. AUTENTICAÇÃO (CADASTRO)
  // ----------------------------------------------------

  /// Cadastra um novo usuário no Supabase.
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final AuthResponse response = await client.auth.signUp(
        email: email,
        password: password,
        // Você pode adicionar metadata do usuário (como o nome) no `data`
        data: {'full_name': name},
      );

      // Verifica se a resposta contém um erro de confirmação
      if (response.user != null && response.user!.emailConfirmedAt == null) {
        // Lógica de sucesso, mas pode exigir confirmação de e-mail
        print('Cadastro realizado! Confirmação de e-mail pode ser necessária.');
      }

    } on AuthException catch (e) {
      // Lança uma exceção para que a UI possa mostrar a mensagem de erro
      throw Exception('Erro de Autenticação: ${e.message}');
    } catch (e) {
      throw Exception('Erro desconhecido ao cadastrar: $e');
    }
  }

  // ----------------------------------------------------
  // 3. AUTENTICAÇÃO (LOGIN)
  // ----------------------------------------------------

  /// Faz o login de um usuário existente.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // O Supabase lida automaticamente com a persistência da sessão.
    } on AuthException catch (e) {
      throw Exception('Erro de Login: ${e.message}');
    } catch (e) {
      throw Exception('Erro desconhecido ao fazer login: $e');
    }
  }

  // ----------------------------------------------------
  // 4. SESSÃO E LOGOUT
  // ----------------------------------------------------

  /// Retorna o ID do usuário atualmente logado, ou null.
  String? get userId => client.auth.currentUser?.id;

  /// Faz o logout do usuário.
  Future<void> signOut() async {
    await client.auth.signOut();
  }
}