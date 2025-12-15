import 'package:supabase_flutter/supabase_flutter.dart';

/// Serviço de autenticação usando Supabase
class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Client do Supabase
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Verifica se o usuário está logado
  bool get isLoggedIn => _supabase.auth.currentUser != null;

  /// Obtém o usuário atual
  User? get currentUser => _supabase.auth.currentUser;

  /// Faz login com email e senha
  ///
  /// Retorna um Map com:
  /// - 'success': bool - se o login foi bem-sucedido
  /// - 'message': String - mensagem de erro ou sucesso
  /// - 'user': User? - dados do usuário (se sucesso)
  Future<Map<String, dynamic>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      print('🔐 Tentando login com email: $email');
      
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      print('📧 Resposta do Supabase recebida');

      if (response.user != null) {
        print('✅ Login bem-sucedido para: ${response.user!.email}');
        return {
          'success': true,
          'message': 'Login realizado com sucesso!',
          'user': response.user,
        };
      } else {
        print('❌ Login falhou: usuário nulo');
        return {
          'success': false,
          'message': 'Erro ao fazer login. Tente novamente.',
        };
      }
    } on AuthException catch (e) {
      print('❌ AuthException: ${e.message}');
      // Tratamento de erros específicos do Supabase
      String errorMessage = e.message;
      
      // Mensagens personalizadas para erros comuns
      if (e.message.toLowerCase().contains('invalid login')) {
        errorMessage = 'Email ou senha incorretos.';
      } else if (e.message.toLowerCase().contains('email not confirmed')) {
        errorMessage = 'Email não confirmado. Verifique seu email.';
      } else if (e.message.toLowerCase().contains('invalid email')) {
        errorMessage = 'Email inválido.';
      }

      return {'success': false, 'message': errorMessage};
    } catch (e) {
      print('❌ Erro inesperado: $e');
      return {'success': false, 'message': 'Erro ao conectar: ${e.toString()}'};
    }
  }

  /// Faz cadastro de novo usuário
  Future<Map<String, dynamic>> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: metadata,
      );

      if (response.user != null) {
        return {
          'success': true,
          'message': 'Cadastro realizado! Verifique seu email.',
          'user': response.user,
        };
      } else {
        return {
          'success': false,
          'message': 'Erro ao criar conta. Tente novamente.',
        };
      }
    } on AuthException catch (e) {
      return {'success': false, 'message': e.message};
    } catch (e) {
      return {'success': false, 'message': 'Erro inesperado: ${e.toString()}'};
    }
  }

  /// Faz logout
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Recupera senha
  Future<Map<String, dynamic>> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      return {'success': true, 'message': 'Email de recuperação enviado!'};
    } catch (e) {
      return {
        'success': false,
        'message': 'Erro ao enviar email: ${e.toString()}',
      };
    }
  }

  /// Stream de mudanças de autenticação
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
}
