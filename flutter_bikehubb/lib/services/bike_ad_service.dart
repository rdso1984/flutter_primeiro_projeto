import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/bike_ad.dart';

class BikeAdService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Busca todos os anúncios do usuário logado
  Future<List<BikeAd>> getUserBikes() async {
    try {
      final userEmail = _supabase.auth.currentUser?.email;
      
      if (userEmail == null) {
        print('❌ Usuário não está logado');
        return [];
      }

      print('🔍 Buscando anúncios do usuário: $userEmail');

      // Busca o user_id (bigint) na tabela users usando o UUID do auth
      final userResponse = await _supabase
          .from('users')
          .select('id')
          .eq('external_id', _supabase.auth.currentUser!.id)
          .single();
      
      final userId = userResponse['id'];
      print('📋 User ID encontrado: $userId');

      final response = await _supabase
          .from('bicycles')
          .select('''
            id,
            title,
            description,
            price,
            condition,
            city,
            state,
            is_active,
            is_paid,
            expires_at,
            created_at,
            payment_date,
            status,
            user_id,
            bike_images!inner(id, original_filename, is_primary, bicycle_id)
          ''')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      print('📦 Resposta do Supabase: ${response.length} anúncios encontrados');

      final bikes = (response as List).map((item) {
        // Pega a primeira imagem ou a imagem primária
        String imageUrl = '';
        if (item['bike_images'] != null && (item['bike_images'] as List).isNotEmpty) {
          final images = item['bike_images'] as List;
          // Tenta encontrar a imagem primária primeiro
          final primaryImage = images.firstWhere(
            (img) => img['is_primary'] == true,
            orElse: () => images.first,
          );
          
          // Constrói a URL do Supabase Storage
          final imageId = primaryImage['id'];  // UUID da imagem, não da bicicleta
          final filename = primaryImage['original_filename'];
          
          print('📷 DEBUG - image_id: $imageId');
          print('📷 DEBUG - filename: $filename');
          
          // Formato correto: bicycle-images/{image_id}/{timestamp-filename}
          imageUrl = _supabase.storage
              .from('bicycle-images')
              .getPublicUrl('$imageId/$filename');
          
          print('🔗 URL gerada: $imageUrl');
        }
        
        // Adiciona a URL da imagem no item
        final itemWithImage = Map<String, dynamic>.from(item);
        itemWithImage['image_url'] = imageUrl;
        
        return BikeAd.fromJson(itemWithImage);
      }).toList();

      print('✅ ${bikes.length} anúncios carregados');
      return bikes;
    } catch (e) {
      print('❌ Erro ao buscar anúncios: $e');
      return [];
    }
  }

  /// Busca anúncios em destaque (para página inicial)
  Future<List<BikeAd>> getFeaturedBikes({int limit = 4}) async {
    try {
      print('🔍 Buscando anúncios em destaque...');

      final response = await _supabase
          .from('bicycles')
          .select('''
            id,
            title,
            description,
            price,
            condition,
            city,
            state,
            is_active,
            is_paid,
            expires_at,
            created_at,
            payment_date,
            status,
            user_id,
            bike_images!inner(id, original_filename, is_primary, bicycle_id)
          ''')
          .eq('is_active', true)
          .eq('is_paid', true)
          .order('created_at', ascending: false)
          .limit(limit);

      print('📦 ${response.length} anúncios em destaque encontrados');

      final bikes = (response as List).map((item) {
        String imageUrl = '';
        if (item['bike_images'] != null && (item['bike_images'] as List).isNotEmpty) {
          final images = item['bike_images'] as List;
          final primaryImage = images.firstWhere(
            (img) => img['is_primary'] == true,
            orElse: () => images.first,
          );
          
          final imageId = primaryImage['id'];
          final filename = primaryImage['original_filename'];
          imageUrl = _supabase.storage
              .from('bicycle-images')
              .getPublicUrl('$imageId/$filename');
        }
        
        final itemWithImage = Map<String, dynamic>.from(item);
        itemWithImage['image_url'] = imageUrl;
        
        return BikeAd.fromJson(itemWithImage);
      }).toList();

      return bikes;
    } catch (e) {
      print('❌ Erro ao buscar anúncios em destaque: $e');
      return [];
    }
  }

  /// Busca anúncio por ID
  Future<BikeAd?> getBikeById(String id) async {
    try {
      final response = await _supabase
          .from('bicycles')
          .select('''
            id,
            title,
            description,
            price,
            condition,
            city,
            state,
            is_active,
            is_paid,
            expires_at,
            created_at,
            payment_date,
            status,
            user_id,
            bike_images(id, original_filename, is_primary, bicycle_id)
          ''')
          .eq('id', id)
          .single();

      String imageUrl = '';
      if (response['bike_images'] != null && (response['bike_images'] as List).isNotEmpty) {
        final images = response['bike_images'] as List;
        final primaryImage = images.firstWhere(
          (img) => img['is_primary'] == true,
          orElse: () => images.first,
        );
        
        final imageId = primaryImage['id'];
        final filename = primaryImage['original_filename'];
        imageUrl = _supabase.storage
            .from('bicycle-images')
            .getPublicUrl('$imageId/$filename');
      }
      
      final itemWithImage = Map<String, dynamic>.from(response);
      itemWithImage['image_url'] = imageUrl;

      return BikeAd.fromJson(itemWithImage);
    } catch (e) {
      print('❌ Erro ao buscar anúncio: $e');
      return null;
    }
  }

  /// Atualiza o status de pagamento do anúncio
  Future<bool> markAsPaid(String bikeId) async {
    try {
      await _supabase
          .from('bicycles')
          .update({
            'is_paid': true,
            'payment_date': DateTime.now().toIso8601String(),
            'status': 'active',
          })
          .eq('id', bikeId);

      print('✅ Anúncio marcado como pago');
      return true;
    } catch (e) {
      print('❌ Erro ao atualizar pagamento: $e');
      return false;
    }
  }

  /// Exclui um anúncio
  Future<bool> deleteBike(String bikeId) async {
    try {
      await _supabase.from('bicycles').delete().eq('id', bikeId);

      print('✅ Anúncio excluído');
      return true;
    } catch (e) {
      print('❌ Erro ao excluir anúncio: $e');
      return false;
    }
  }

  /// Calcula estatísticas dos anúncios do usuário
  Future<Map<String, int>> getUserBikesStats() async {
    try {
      final userEmail = _supabase.auth.currentUser?.email;
      
      if (userEmail == null) return {};

      final bikes = await getUserBikes();

      final stats = {
        'active': bikes.where((b) => b.isActive && b.isPaid).length,
        'total': bikes.length,
        'pendingPayment': bikes.where((b) => !b.isPaid).length,
        'expiringSoon': bikes.where((b) => b.expiresIn7Days).length,
      };

      print('📊 Estatísticas: $stats');
      return stats;
    } catch (e) {
      print('❌ Erro ao calcular estatísticas: $e');
      return {};
    }
  }

  /// Busca todos os anúncios (para uso geral)
  Future<List<BikeAd>> getAllBikes() async {
    try {
      final response = await _supabase
          .from('bicycles')
          .select('''
            id,
            title,
            description,
            price,
            condition,
            city,
            state,
            is_active,
            is_paid,
            expires_at,
            created_at,
            payment_date,
            status,
            user_id,
            bike_images(id, original_filename, is_primary, bicycle_id)
          ''')
          .order('created_at', ascending: false);

      final bikes = (response as List).map((item) {
        String imageUrl = '';
        if (item['bike_images'] != null && (item['bike_images'] as List).isNotEmpty) {
          final images = item['bike_images'] as List;
          final primaryImage = images.firstWhere(
            (img) => img['is_primary'] == true,
            orElse: () => images.first,
          );
          
          final imageId = primaryImage['id'];
          final filename = primaryImage['original_filename'];
          imageUrl = _supabase.storage
              .from('bicycle-images')
              .getPublicUrl('$imageId/$filename');
        }
        
        final itemWithImage = Map<String, dynamic>.from(item);
        itemWithImage['image_url'] = imageUrl;
        
        return BikeAd.fromJson(itemWithImage);
      }).toList();

      return bikes;
    } catch (e) {
      print('❌ Erro ao buscar todos os anúncios: $e');
      return [];
    }
  }

  /// Busca anúncios por filtros
  Future<List<BikeAd>> searchBikes({
    String? query,
    double? maxPrice,
    String? condition,
  }) async {
    try {
      var queryBuilder = _supabase
          .from('bicycles')
          .select('''
            id,
            title,
            description,
            price,
            condition,
            city,
            state,
            is_active,
            is_paid,
            expires_at,
            created_at,
            payment_date,
            status,
            user_id,
            bike_images(id, original_filename, is_primary, bicycle_id)
          ''')
          .eq('is_active', true)
          .eq('is_paid', true);

      if (query != null && query.isNotEmpty) {
        queryBuilder = queryBuilder.or('title.ilike.%$query%,description.ilike.%$query%');
      }

      if (maxPrice != null) {
        queryBuilder = queryBuilder.lte('price', maxPrice);
      }

      if (condition != null) {
        queryBuilder = queryBuilder.eq('condition', condition);
      }

      final response = await queryBuilder.order('created_at', ascending: false);

      final bikes = (response as List).map((item) {
        String imageUrl = '';
        if (item['bike_images'] != null && (item['bike_images'] as List).isNotEmpty) {
          final images = item['bike_images'] as List;
          final primaryImage = images.firstWhere(
            (img) => img['is_primary'] == true,
            orElse: () => images.first,
          );
          
          final imageId = primaryImage['id'];
          final filename = primaryImage['original_filename'];
          imageUrl = _supabase.storage
              .from('bicycle-images')
              .getPublicUrl('$imageId/$filename');
        }
        
        final itemWithImage = Map<String, dynamic>.from(item);
        itemWithImage['image_url'] = imageUrl;
        
        return BikeAd.fromJson(itemWithImage);
      }).toList();

      return bikes;
    } catch (e) {
      print('❌ Erro ao buscar anúncios: $e');
      return [];
    }
  }
}
