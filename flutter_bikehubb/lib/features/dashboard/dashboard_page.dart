import 'package:bikehubb/common/app_constants.dart';
import 'package:bikehubb/services/auth_service.dart';
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.3, 
      end: 1.0
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
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
    final user = _authService.currentUser;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.cardBackground,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 36, 42, 35),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAssets.logo,
                    width: 64,
                    height: 64,
                  ),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  const Text(
                    'BikeHubb',
                    style: AppTextStyles.titleMedium,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: AppColors.textWhite),
              title: const Text('Dashboard', style: AppTextStyles.bodyText),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.textWhite),
              title: const Text('Sair', style: AppTextStyles.bodyText),
              onTap: _handleLogout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: AnimatedBuilder(
          animation: _fadeAnimation, 
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 12),
                const Text(
                  'BikeHubb',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleMedium,
                ),
              ],
            );
          }
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.logout, color: AppColors.primaryGreen),
        //     onPressed: _handleLogout,
        //     tooltip: 'Sair',
        //   ),
        // ],
      ),

      body: Container(
        color: AppColors.backgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.primaryGreen,
                  size: 80,
                ),
                const SizedBox(height: AppDimensions.paddingLarge),
                const Text(
                  'Bem-vindo ao Dashboard!',
                  style: AppTextStyles.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                if (user?.email != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadius,
                      ),
                      border: Border.all(
                        color: AppColors.primaryGreen,
                        width: AppDimensions.borderWidthThin,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Usuário logado:',
                          style: AppTextStyles.subtitle,
                        ),
                        const SizedBox(height: AppDimensions.paddingSmall),
                        Text(user!.email!, style: AppTextStyles.titleSmall),
                        const SizedBox(height: AppDimensions.paddingSmall),
                        Text(
                          'ID: ${user.id}',
                          style: AppTextStyles.bodyTextSmall,
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppDimensions.paddingLarge),
                ElevatedButton(
                  onPressed: _handleLogout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: AppColors.textWhite,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: AppDimensions.paddingLarge,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadius,
                      ),
                    ),
                  ),
                  child: const Text('SAIR', style: AppTextStyles.button),
                ),
              ],
            ),
          ),
        ),
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
