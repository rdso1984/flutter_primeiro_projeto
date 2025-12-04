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
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                child: bikeAd.imageUrl.startsWith('http')
                    ? Image.network(
                        bikeAd.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(0xFF1c222e),
                            child: Icon(
                              Icons.pedal_bike,
                              size: 60,
                              color: Colors.white54,
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
                            child: Icon(
                              Icons.pedal_bike,
                              size: 60,
                              color: Colors.white54,
                            ),
                          );
                        },
                      ),
                ),
              ),
            ),
            // Informações do anúncio
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Título
                  Text(
                    bikeAd.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Condição
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
