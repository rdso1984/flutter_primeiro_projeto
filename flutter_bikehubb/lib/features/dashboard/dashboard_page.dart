import 'package:bikehubb/common/app_constants.dart';
import 'package:bikehubb/common/commom_components.dart';
import 'package:bikehubb/features/shared/app_footer.dart';
import 'package:bikehubb/features/shared/bikehubb_appbar.dart';
import 'package:bikehubb/features/shared/bikehubb_drawer.dart';
import 'package:bikehubb/models/bike_ad.dart';
import 'package:bikehubb/services/auth_service.dart';
import 'package:bikehubb/services/bike_ad_service.dart';
import 'package:bikehubb/widgets/bike_ad_card.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  late Animation<double> _fadeAnimation;
  late AnimationController _animationController;
  final BikeAdService _bikeAdService = BikeAdService();

  // Anúncios mockados para teste
  List<BikeAd> _getMockBikes() {
    return [
      BikeAd(
        id: '1',
        title: 'Mountain Bike Caloi Explorer',
        description: 'Bicicleta de montanha aro 29, 21 marchas, freios a disco',
        price: 1500.00,
        imageUrl: 'https://images.unsplash.com/photo-1576435728678-68d0fbf94e91?w=500',
        condition: 'used',
        location: 'São Paulo, SP',
      ),
      BikeAd(
        id: '2',
        title: 'Speed Oggi Velloce Disc',
        description: 'Bicicleta speed de alta performance, carbono',
        price: 3200.00,
        imageUrl: 'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=500',
        condition: 'excellent',
        location: 'Rio de Janeiro, RJ',
      ),
      BikeAd(
        id: '3',
        title: 'BMX Street Edition',
        description: 'BMX para manobras e street, rodas reforçadas',
        price: 800.00,
        imageUrl: 'https://images.unsplash.com/photo-1532298229144-0ec0c57515c7?w=500',
        condition: 'new',
        location: 'Curitiba, PR',
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('🏗️ Construindo Dashboard...');
    final user = _authService.currentUser;
    print('👤 Usuário: ${user?.email ?? "não encontrado"}');

    return Scaffold(
      appBar: BikeHubbAppBar(fadeAnimation: _fadeAnimation, showDrawer: true),
      drawer: const BikeHubbDrawer(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1c222e), Color(0xFF179447)],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: AppDimensions.paddingLarge),
                  const Text(
                    'Bem-vindo \n ao Dashboard!',
                    style: AppTextStyles.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppDimensions.paddingMedium),
                  Text(
                    'Gerencie seus anúncios de bicicletas',
                    style: AppTextStyles.subtitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.paddingXXLarge),
                  NavigationButton(
                    label: 'Novo Anúncio',
                    navigationTo: '/novo_anuncio',
                  ),
                  const SizedBox(height: AppDimensions.paddingXXLarge),
                  // Estatísticas dos Anúncios
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                'Anúncios Ativos',
                                '0',
                                Icons.check_circle_outline,
                                AppColors.primaryGreen,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                'Total de Anúncios',
                                '0',
                                Icons.list_alt,
                                Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                'Aguardando Pagamento',
                                '0',
                                Icons.payment,
                                Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                'Expiram em 7 dias',
                                '0',
                                Icons.schedule,
                                Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppDimensions.paddingXXLarge),
                       
                        const Text(
                          'Meus Anúncios',
                          style: AppTextStyles.titleLarge,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: AppDimensions.paddingMedium),
                        // Usando anúncios mockados temporariamente
                        ..._getMockBikes().map((bike) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildBikeAdCardWithActions(bike),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppFooter(),
          ],
        ),
      ),

      // if (user?.email != null) ...[
      //   Container(
      //     padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      //     decoration: BoxDecoration(
      //       color: AppColors.cardBackground,
      //       borderRadius: BorderRadius.circular(
      //         AppDimensions.borderRadius,
      //       ),
      //       border: Border.all(
      //         color: AppColors.primaryGreen,
      //         width: AppDimensions.borderWidthThin,
      //       ),
      //     ),
      //     child: Column(
      //       children: [
      //         const Text(
      //           'Usuário logado:',
      //           style: AppTextStyles.subtitle,
      //         ),
      //         const SizedBox(height: AppDimensions.paddingSmall),
      //         Text(user!.email!, style: AppTextStyles.titleSmall),
      //         const SizedBox(height: AppDimensions.paddingSmall),
      //         Text(
      //           'ID: ${user.id}',
      //           style: AppTextStyles.bodyTextSmall,
      //         ),
      //       ],
      //     ),
      //   ),
      // ],

      //botao sair
      // const SizedBox(height: AppDimensions.paddingLarge),
      // ElevatedButton(
      //   onPressed: _handleLogout,
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: AppColors.primaryGreen,
      //     foregroundColor: AppColors.textWhite,
      //     padding: const EdgeInsets.symmetric(
      //       vertical: 16,
      //       horizontal: AppDimensions.paddingLarge,
      //     ),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(
      //         AppDimensions.borderRadius,
      //       ),
      //     ),
      //   ),
      //   child: const Text('SAIR', style: AppTextStyles.button),
      // ),
    );
  }

  Widget _buildBikeAdCardWithActions(BikeAd bike) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryGreen.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Card do anúncio
          BikeAdCard(
            bikeAd: bike,
            onTap: () {
              print('Clicou no anúncio: ${bike.title}');
            },
          ),
          
          // Botões de ação
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botão Pagar
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _handlePayment(bike),
                    icon: const Icon(Icons.payment, size: 18),
                    label: const Text('Pagar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                // Botão Editar
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _handleEdit(bike),
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Editar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                // Botão Excluir
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _handleDelete(bike),
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Excluir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handlePayment(BikeAd bike) {
    // TODO: Implementar lógica de pagamento
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Pagar Taxa',
          style: TextStyle(color: AppColors.textWhite),
        ),
        content: Text(
          'Processar pagamento para o anúncio: ${bike.title}',
          style: const TextStyle(color: AppColors.textWhite70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidade de pagamento em desenvolvimento'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Confirmar Pagamento'),
          ),
        ],
      ),
    );
  }

  void _handleEdit(BikeAd bike) {
    // TODO: Implementar navegação para tela de edição
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editar anúncio: ${bike.title}'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _handleDelete(BikeAd bike) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Confirmar Exclusão',
          style: TextStyle(color: AppColors.textWhite),
        ),
        content: Text(
          'Deseja realmente excluir o anúncio "${bike.title}"?',
          style: const TextStyle(color: AppColors.textWhite70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar lógica de exclusão no banco
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Anúncio "${bike.title}" excluído'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Confirmar Saída',
          style: TextStyle(color: AppColors.textWhite),
        ),
        content: const Text(
          'Deseja realmente sair?',
          style: TextStyle(color: AppColors.textWhite70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: AppColors.textWhite70),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
            ),
            child: const Text('Sair'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await _authService.signOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    }
  }
}
