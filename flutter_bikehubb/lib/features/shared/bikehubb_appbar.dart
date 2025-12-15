import 'package:bikehubb/common/app_constants.dart';
import 'package:flutter/material.dart';

/// AppBar customizado do BikeHubb
/// Contém logo, título animado e menu de opções
class BikeHubbAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Animation<double> fadeAnimation;
  final bool showDrawer;

  const BikeHubbAppBar({
    super.key,
    required this.fadeAnimation,
    this.showDrawer = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      leading: showDrawer
          ? Builder(
              builder: (context) => Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 59, 65, 60),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Image.asset(
                    AppAssets.logo,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            )
          : null,
      title: AnimatedBuilder(
        animation: fadeAnimation,
        builder: (context, child) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 24),
              Text(
                'BikeHubb',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.lerp(
                    AppColors.darkGreen,
                    AppColors.primaryGreen,
                    fadeAnimation.value,
                  ),
                  fontFamily: AppTextStyles.fontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 0),
                      blurRadius: 20,
                      color: AppColors.shadowGreen.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      toolbarHeight: 70,
    );
  }
}
