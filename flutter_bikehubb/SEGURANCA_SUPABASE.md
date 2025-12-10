# 🔐 Guia de Segurança - Supabase no Flutter

## ✅ Melhorias Implementadas

### 1. **Arquivo de Configuração Separado**
- ✅ Credenciais movidas para `lib/config/supabase_config.dart`
- ✅ Arquivo adicionado ao `.gitignore` (não será versionado)
- ✅ Template criado em `supabase_config.example.dart` (pode ser versionado)

### 2. **Estrutura Atual**
```dart
// main.dart
await Supabase.initialize(
  url: SupabaseConfig.supabaseUrl,
  anonKey: SupabaseConfig.supabaseAnonKey,
);
```

## 🔑 Tipos de Chaves do Supabase

### **Anon Key (Chave Pública)** ✅ Seguro expor
- Usada no frontend (aplicativos móveis e web)
- Permite apenas operações autorizadas pelas RLS (Row Level Security)
- **Já implementado corretamente no seu app**

### **Service Role Key** ⚠️ NUNCA expor
- Chave secreta com acesso total ao banco
- Deve ser usada **APENAS** no backend/servidor
- **NUNCA** inclua no código do app Flutter

## 🛡️ Camadas de Segurança

### **1. Row Level Security (RLS)** - Mais Importante!

O RLS é a **principal defesa** do Supabase. Configure políticas de segurança:

```sql
-- Exemplo: Usuário só pode ver seus próprios dados
CREATE POLICY "Users can view own data"
ON profiles FOR SELECT
USING (auth.uid() = id);

-- Exemplo: Usuário só pode atualizar seus próprios dados
CREATE POLICY "Users can update own data"
ON profiles FOR UPDATE
USING (auth.uid() = id);

-- Exemplo: Qualquer um pode ler anúncios públicos
CREATE POLICY "Public bikes are viewable by everyone"
ON bike_ads FOR SELECT
USING (status = 'public');
```

#### **Como habilitar RLS no Supabase:**
1. Acesse: https://app.supabase.com/project/krlhnihkslmmihprkwqm
2. Vá em **Database** → **Tables**
3. Para cada tabela:
   - Clique nos 3 pontos → **Edit table**
   - Marque **Enable RLS**
   - Crie políticas específicas

### **2. Validação no Backend**

Para operações sensíveis, use **Database Functions** ou **Edge Functions**:

```sql
-- Exemplo: Function para validar operação antes de executar
CREATE OR REPLACE FUNCTION validate_user_action(user_id UUID)
RETURNS BOOLEAN AS $$
BEGIN
  -- Sua lógica de validação aqui
  RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

### **3. Proteção de Rotas no App**

```dart
// Proteger rotas que exigem autenticação
class ProtectedRoute extends StatelessWidget {
  final Widget child;
  
  const ProtectedRoute({required this.child});
  
  @override
  Widget build(BuildContext context) {
    if (!AuthService().isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const SizedBox();
    }
    return child;
  }
}

// Uso:
routes: {
  '/dashboard': (context) => const ProtectedRoute(
    child: DashboardPage(),
  ),
}
```

## ⚠️ O Que NÃO Fazer

### ❌ **1. Expor Service Role Key**
```dart
// NUNCA faça isso!
const serviceRoleKey = 'eyJ...sua_service_role_key';
```

### ❌ **2. Lógica de Segurança no Frontend**
```dart
// ERRADO: Validação apenas no frontend
if (user.isAdmin) {
  deleteUser(); // Pode ser contornado
}

// CORRETO: Validação no backend (RLS/Functions)
```

### ❌ **3. Confiar em dados do cliente**
```dart
// ERRADO: Aceitar userId do frontend
await supabase.from('profiles')
  .update({'role': 'admin'})
  .eq('id', userId); // Usuário pode manipular!

// CORRETO: Usar auth.uid() no RLS
CREATE POLICY "Users can only update own profile"
ON profiles FOR UPDATE
USING (auth.uid() = id);
```

## 🔒 Checklist de Segurança

### **Configuração Atual** ✅
- [x] Anon Key movida para arquivo separado
- [x] Arquivo de config no .gitignore
- [x] Template de exemplo criado
- [x] Autenticação implementada corretamente

### **Recomendações Adicionais** (Importantes!)

#### **1. Habilite RLS em TODAS as tabelas**
```sql
-- Para todas as suas tabelas
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE bike_ads ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
```

#### **2. Crie políticas específicas**
```sql
-- Exemplo para tabela de anúncios
CREATE POLICY "Users can view public ads"
ON bike_ads FOR SELECT
TO authenticated
USING (status = 'active');

CREATE POLICY "Users can manage own ads"
ON bike_ads FOR ALL
TO authenticated
USING (auth.uid() = owner_id);
```

#### **3. Proteja operações sensíveis**
```sql
-- Não permita que usuários mudem seu próprio role
CREATE POLICY "Prevent role changes"
ON profiles FOR UPDATE
TO authenticated
USING (auth.uid() = id)
WITH CHECK (
  COALESCE(NEW.role, OLD.role) = OLD.role
);
```

#### **4. Configure Email Confirmação**
1. Vá em **Authentication** → **Settings**
2. Ative **Email Confirmations**
3. Personalize os templates de email

#### **5. Configure Rate Limiting**
1. Vá em **Settings** → **API**
2. Configure limites de requisições

#### **6. Use Variáveis de Ambiente (Futuro)**
Para projetos maiores, considere usar `flutter_dotenv`:

```yaml
# pubspec.yaml
dependencies:
  flutter_dotenv: ^5.1.0
```

```dart
// .env (não versionado)
SUPABASE_URL=https://krlhnihkslmmihprkwqm.supabase.co
SUPABASE_ANON_KEY=eyJ...

// main.dart
await dotenv.load();
await Supabase.initialize(
  url: dotenv.env['SUPABASE_URL']!,
  anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
);
```

## 📊 Níveis de Segurança

### **Nível 1: Básico** (Atual) ✅
- Anon Key no arquivo separado
- Arquivo no .gitignore
- Autenticação funcionando

### **Nível 2: Intermediário** (Recomendado)
- ✅ RLS habilitado em todas as tabelas
- ✅ Políticas específicas por operação
- ✅ Email de confirmação ativo
- ✅ Proteção de rotas no app

### **Nível 3: Avançado** (Para produção)
- ✅ Edge Functions para lógica complexa
- ✅ Rate limiting configurado
- ✅ Logs de auditoria
- ✅ 2FA (autenticação de dois fatores)
- ✅ Monitoramento de acessos
- ✅ Backups automáticos

## 🚨 Monitoramento

### **1. Logs de Autenticação**
Acesse: **Authentication** → **Logs**
- Monitore tentativas de login
- Identifique acessos suspeitos

### **2. API Logs**
Acesse: **Logs** → **API**
- Veja todas as requisições
- Identifique padrões anormais

### **3. Database Activity**
Acesse: **Database** → **Roles**
- Monitore atividades do banco
- Configure alertas

## 📝 Boas Práticas Gerais

### **1. Nunca Comite Credenciais**
```bash
# Sempre verifique antes de comitar
git status
git diff

# Se acidentalmente commitou:
git rm --cached lib/config/supabase_config.dart
```

### **2. Rotação de Chaves**
- Troque a Anon Key a cada 6-12 meses
- Se suspeitar de vazamento, gere nova chave imediatamente

### **3. Separe Ambientes**
```dart
class SupabaseConfig {
  static const bool isProduction = bool.fromEnvironment('PRODUCTION');
  
  static String get supabaseUrl => isProduction 
    ? 'https://prod.supabase.co'
    : 'https://dev.supabase.co';
}
```

### **4. Code Review**
- Sempre revise código antes de fazer push
- Use ferramentas de análise estática
- Configure pre-commit hooks

## 🎯 Próximos Passos Recomendados

1. **Imediato**: Habilite RLS em todas as tabelas
2. **Esta semana**: Crie políticas específicas para cada operação
3. **Este mês**: Configure email de confirmação e 2FA
4. **Futuro**: Implemente Edge Functions para lógica complexa

## 📚 Recursos Úteis

- [Supabase RLS Guide](https://supabase.com/docs/guides/auth/row-level-security)
- [Flutter Security Best Practices](https://flutter.dev/docs/development/data-and-backend/security)
- [OWASP Mobile Security](https://owasp.org/www-project-mobile-security/)

## ✅ Resumo

**Sua aplicação está em um nível de segurança BÁSICO mas funcional.**

### O que já está seguro:
- ✅ Anon Key (pode ser exposta)
- ✅ Não está expondo Service Role Key
- ✅ Autenticação implementada

### O que precisa ser feito (RLS é crítico!):
1. **Habilitar RLS** nas tabelas do Supabase
2. **Criar políticas** de acesso
3. **Configurar email** de confirmação
4. **Proteger rotas** no app

**A Anon Key pode ser exposta, mas o RLS é essencial para proteger seus dados!**
