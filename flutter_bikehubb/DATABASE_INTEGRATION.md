# Integração com Banco de Dados - BikeHubb

Este documento explica como integrar os anúncios de bicicletas com diferentes bancos de dados.

## Estrutura Criada

### 1. Modelo de Dados (`lib/models/bike_ad.dart`)
Define a estrutura do anúncio de bicicleta com:
- `id`: Identificador único
- `title`: Título do anúncio
- `description`: Descrição da bicicleta
- `price`: Preço
- `imageUrl`: URL ou caminho da imagem
- `condition`: Condição (nova, usada, excelente)
- `location`: Localização

### 2. Serviço (`lib/services/bike_ad_service.dart`)
Gerencia a comunicação com o banco de dados. Atualmente com dados mock, mas preparado para integração real.

### 3. Widget de Card (`lib/widgets/bike_ad_card.dart`)
Componente visual reutilizável que exibe cada anúncio.

## Como Integrar com Banco de Dados

### Opção 1: Firebase Firestore

1. Adicione as dependências no `pubspec.yaml`:
```yaml
dependencies:
  firebase_core: ^2.24.0
  cloud_firestore: ^4.13.0
```

2. Configure o Firebase no seu projeto

3. Atualize o método `getFeaturedBikes` em `bike_ad_service.dart`:
```dart
Future<List<BikeAd>> getFeaturedBikes({int limit = 4}) async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('bike_ads')
      .where('featured', isEqualTo: true)
      .orderBy('createdAt', descending: true)
      .limit(limit)
      .get();
  
  return snapshot.docs
      .map((doc) => BikeAd.fromJson({
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id,
      }))
      .toList();
}
```

### Opção 2: Supabase

1. Adicione a dependência:
```yaml
dependencies:
  supabase_flutter: ^2.0.0
```

2. Configure o Supabase

3. Atualize o serviço:
```dart
Future<List<BikeAd>> getFeaturedBikes({int limit = 4}) async {
  final response = await Supabase.instance.client
      .from('bike_ads')
      .select()
      .eq('featured', true)
      .order('created_at', ascending: false)
      .limit(limit);
  
  return (response as List)
      .map((item) => BikeAd.fromJson(item))
      .toList();
}
```

### Opção 3: API REST

1. Adicione a dependência:
```yaml
dependencies:
  http: ^1.1.0
```

2. Atualize o serviço:
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<BikeAd>> getFeaturedBikes({int limit = 4}) async {
  final response = await http.get(
    Uri.parse('https://sua-api.com/api/bike-ads?featured=true&limit=$limit'),
    headers: {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer YOUR_TOKEN', // se necessário
    },
  );
  
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((item) => BikeAd.fromJson(item)).toList();
  } else {
    throw Exception('Falha ao carregar anúncios: ${response.statusCode}');
  }
}
```

### Opção 4: SQLite Local

1. Adicione as dependências:
```yaml
dependencies:
  sqflite: ^2.3.0
  path: ^1.8.3
```

2. Crie um helper de banco de dados:
```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bikehubb.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bike_ads(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        imageUrl TEXT,
        condition TEXT,
        location TEXT,
        featured INTEGER DEFAULT 0
      )
    ''');
  }
}
```

3. Atualize o serviço:
```dart
Future<List<BikeAd>> getFeaturedBikes({int limit = 4}) async {
  final db = await DatabaseHelper.instance.database;
  
  final List<Map<String, dynamic>> maps = await db.query(
    'bike_ads',
    where: 'featured = ?',
    whereArgs: [1],
    limit: limit,
    orderBy: 'created_at DESC',
  );

  return maps.map((map) => BikeAd.fromJson(map)).toList();
}
```

## Estrutura do Banco de Dados Sugerida

### Tabela/Coleção: `bike_ads`

| Campo | Tipo | Descrição |
|-------|------|-----------|
| id | String | ID único do anúncio |
| title | String | Título do anúncio |
| description | String | Descrição detalhada |
| price | Number | Preço em reais |
| imageUrl | String | URL ou caminho da imagem |
| condition | String | 'new', 'used', 'excellent' |
| location | String | Cidade e estado |
| featured | Boolean | Se é destaque na home |
| createdAt | Timestamp | Data de criação |
| userId | String | ID do usuário que criou |

## Armazenamento de Imagens

### Firebase Storage
```dart
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<String> uploadBikeImage(File imageFile, String bikeId) async {
  final ref = FirebaseStorage.instance
      .ref()
      .child('bike_images')
      .child('$bikeId.jpg');
  
  await ref.putFile(imageFile);
  return await ref.getDownloadURL();
}
```

### Supabase Storage
```dart
Future<String> uploadBikeImage(File imageFile, String bikeId) async {
  final bytes = await imageFile.readAsBytes();
  final fileExt = imageFile.path.split('.').last;
  final fileName = '$bikeId.$fileExt';
  
  await Supabase.instance.client.storage
      .from('bike-images')
      .uploadBinary(fileName, bytes);
  
  return Supabase.instance.client.storage
      .from('bike-images')
      .getPublicUrl(fileName);
}
```

## Testando a Implementação

A implementação atual já funciona com dados mock. Para testar:

1. Execute o app: `flutter run`
2. Navegue até a home page
3. Role até a seção "Bicicletas em Destaque"
4. Você verá 4 cards com anúncios de exemplo

## Próximos Passos

1. Escolha seu banco de dados preferido
2. Configure as credenciais
3. Substitua o método `getFeaturedBikes` no `bike_ad_service.dart`
4. Implemente o upload de imagens
5. Crie as telas de detalhes e cadastro de anúncios
