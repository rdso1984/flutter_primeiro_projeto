/// Configurações do Supabase - EXEMPLO
/// 
/// INSTRUÇÕES:
/// 1. Copie este arquivo e renomeie para: supabase_config.dart
/// 2. Preencha com suas credenciais reais do Supabase
/// 3. O arquivo supabase_config.dart NÃO será versionado (está no .gitignore)
/// 
/// Como obter suas credenciais:
/// 1. Acesse: https://app.supabase.com
/// 2. Selecione seu projeto
/// 3. Vá em Settings → API
/// 4. Copie a URL e a anon/public key

class SupabaseConfig {
  // URL do projeto Supabase
  static const String supabaseUrl = 'https://seu-projeto.supabase.co';
  
  // Anon Key (chave pública) - pode ser exposta no frontend
  static const String supabaseAnonKey = 'sua-anon-key-aqui';
  
  // NUNCA exponha a Service Role Key no frontend!
  // Use apenas no backend/servidor
}
