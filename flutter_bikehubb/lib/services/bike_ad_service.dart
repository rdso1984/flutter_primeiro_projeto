import '../models/bike_ad.dart';

class BikeAdService {
  // Simulação de busca no banco de dados
  // Substitua isso pela sua implementação real de banco de dados
  Future<List<BikeAd>> getFeaturedBikes({int limit = 4}) async {
    // Simula um delay de rede
    await Future.delayed(Duration(seconds: 1));

    // Dados de exemplo - substitua pela consulta real ao seu banco de dados
    // Exemplo com Firebase, Supabase, SQLite, etc.
    return [
      BikeAd(
        id: '1',
        title: 'Mountain Bike Specialized Rockhopper',
        description: 'Bicicleta de montanha em excelente estado, com suspensão dianteira e freios a disco.',
        price: 2500.00,
        imageUrl: 'https://via.placeholder.com/400x300/1c222e/22c55e?text=Mountain+Bike',
        condition: 'excellent',
        location: 'São Paulo, SP',
      ),
      BikeAd(
        id: '2',
        title: 'Speed Bike Caloi 10',
        description: 'Bicicleta speed para estrada, leve e rápida.',
        price: 1800.00,
        imageUrl: 'https://via.placeholder.com/400x300/1c222e/22c55e?text=Speed+Bike',
        condition: 'used',
        location: 'Rio de Janeiro, RJ',
      ),
      BikeAd(
        id: '3',
        title: 'Bike Elétrica Sense E-Urban',
        description: 'Bicicleta elétrica nova, ideal para deslocamentos urbanos.',
        price: 4500.00,
        imageUrl: 'https://via.placeholder.com/400x300/1c222e/22c55e?text=E-Bike',
        condition: 'new',
        location: 'Belo Horizonte, MG',
      ),
      BikeAd(
        id: '4',
        title: 'BMX Mongoose Legion',
        description: 'BMX para manobras, estrutura reforçada.',
        price: 1200.00,
        imageUrl: 'https://via.placeholder.com/400x300/1c222e/22c55e?text=BMX',
        condition: 'used',
        location: 'Curitiba, PR',
      ),
    ];

    /* 
    // EXEMPLO COM FIREBASE FIRESTORE:
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('bike_ads')
        .where('featured', isEqualTo: true)
        .limit(limit)
        .get();
    
    return snapshot.docs
        .map((doc) => BikeAd.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    */

    /*
    // EXEMPLO COM SUPABASE:
    final response = await Supabase.instance.client
        .from('bike_ads')
        .select()
        .eq('featured', true)
        .limit(limit);
    
    return (response as List)
        .map((item) => BikeAd.fromJson(item))
        .toList();
    */

    /*
    // EXEMPLO COM API REST:
    final response = await http.get(
      Uri.parse('https://sua-api.com/api/bike-ads?featured=true&limit=$limit'),
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => BikeAd.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar anúncios');
    }
    */
  }

  // Buscar todos os anúncios
  Future<List<BikeAd>> getAllBikes() async {
    await Future.delayed(Duration(seconds: 1));
    
    // Implemente a busca completa aqui
    return getFeaturedBikes(limit: 100);
  }

  // Buscar anúncio por ID
  Future<BikeAd?> getBikeById(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    
    final bikes = await getFeaturedBikes();
    try {
      return bikes.firstWhere((bike) => bike.id == id);
    } catch (e) {
      return null;
    }
  }

  // Buscar por filtros
  Future<List<BikeAd>> searchBikes({
    String? query,
    double? maxPrice,
    String? condition,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    
    var bikes = await getAllBikes();
    
    if (query != null && query.isNotEmpty) {
      bikes = bikes.where((bike) => 
        bike.title.toLowerCase().contains(query.toLowerCase()) ||
        bike.description.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    
    if (maxPrice != null) {
      bikes = bikes.where((bike) => bike.price <= maxPrice).toList();
    }
    
    if (condition != null) {
      bikes = bikes.where((bike) => bike.condition == condition).toList();
    }
    
    return bikes;
  }
}
