import 'package:bikehubb/common/app_constants.dart';
import 'package:flutter/material.dart';

/// Drawer customizado do BikeHubb
/// Menu lateral com navegação para as principais páginas
class BikeHubbDrawer extends StatelessWidget {
  const BikeHubbDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cardBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 36, 42, 35),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.logo,
                  width: 80,
                  height: 80,
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
            leading: const Icon(Icons.home, color: AppColors.primaryGreen),
            title: const Text('Início', style: AppTextStyles.bodyText),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: AppColors.primaryGreen),
            title: const Text('Dashboard', style: AppTextStyles.bodyText),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.login, color: AppColors.primaryGreen),
            title: const Text('Login', style: AppTextStyles.bodyText),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.primaryGreen),
            title: const Text('Logout', style: AppTextStyles.bodyText),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
