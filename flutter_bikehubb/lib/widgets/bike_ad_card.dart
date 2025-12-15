import 'package:flutter/material.dart';
import '../models/bike_ad.dart';

class BikeAdCard extends StatelessWidget {
  final BikeAd bikeAd;
  final VoidCallback? onTap;

  const BikeAdCard({
    super.key,
    required this.bikeAd,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Color(0xFF22c55e),
            width: 1,
          ),
        ),
        color: Color(0xFF2a3240),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem da bicicleta
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: bikeAd.imageUrl.startsWith('http')
                    ? Image.network(
                        bikeAd.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('❌ Erro ao carregar imagem: $error');
                          return Container(
                            color: Color(0xFF1c222e),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_not_supported,
                                      color: Colors.white38, size: 50),
                                  SizedBox(height: 8),
                                  Text(
                                    'Imagem não disponível',
                                    style: TextStyle(color: Colors.white38),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Color(0xFF1c222e),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF22c55e),
                              ),
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        bikeAd.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(0xFF1c222e),
                            child: Center(
                              child: Image.asset(
                                'assets/images/bikehubb_logo.png',
                                width: 80,
                                height: 80,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            // Informações do anúncio
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    bikeAd.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  // Condição
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getConditionColor(bikeAd.condition),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _getConditionText(bikeAd.condition),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Localização
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Color(0xFF22c55e),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          bikeAd.location,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Preço
                  Text(
                    'R\$ ${bikeAd.price.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                      color: Color(0xFF22c55e),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'new':
      case 'nova':
        return Color(0xFF22c55e);
      case 'excellent':
      case 'excelente':
        return Color(0xFF3b82f6);
      case 'used':
      case 'usada':
      default:
        return Color(0xFF64748b);
    }
  }

  String _getConditionText(String condition) {
    switch (condition.toLowerCase()) {
      case 'new':
        return 'Nova';
      case 'excellent':
        return 'Excelente';
      case 'used':
        return 'Usada';
      default:
        return condition;
    }
  }
}
