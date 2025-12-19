import 'package:bikehubb/common/app_constants.dart';
import 'package:bikehubb/features/shared/app_footer.dart';
import 'package:bikehubb/features/shared/bikehubb_appbar.dart';
import 'package:bikehubb/features/shared/bikehubb_drawer.dart';
import 'package:flutter/material.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _fadeAnimation;
  late AnimationController _animationController;

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
  }

  @override
  Widget build(BuildContext context) {
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
                    'Anuncie sua Bicicleta',
                    style: AppTextStyles.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppDimensions.paddingMedium),
                  Text(
                    'Preencha as informações abaixo \npara criar seu anúncio e alcançar \nmilhares de ciclistas',
                    style: AppTextStyles.subtitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.paddingXXLarge),
                ],
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}
