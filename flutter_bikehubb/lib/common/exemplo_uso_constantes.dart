// EXEMPLO DE USO DAS CONSTANTES EM OUTRAS TELAS

import 'package:bikehubb/common/app_constants.dart';
import 'package:flutter/material.dart';

class ExemploUsandoConstantes extends StatelessWidget {
  const ExemploUsandoConstantes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usando cor do AppBar
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: const Text('Exemplo'),
      ),
      
      // Usando cor de background
      body: Container(
        color: AppColors.backgroundColor,
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          children: [
            // Usando logo
            Image.asset(
              AppAssets.logo,
              width: AppDimensions.logoSizeMedium,
              height: AppDimensions.logoSizeMedium,
            ),
            
            const SizedBox(height: AppDimensions.paddingMedium),
            
            // Usando estilos de texto
            const Text(
              'Título da Página',
              style: AppTextStyles.titleLarge,
            ),
            
            const SizedBox(height: AppDimensions.paddingSmall),
            
            const Text(
              'Subtítulo ou descrição',
              style: AppTextStyles.subtitle,
            ),
            
            const SizedBox(height: AppDimensions.paddingLarge),
            
            // Usando campo de input
            TextField(
              style: AppTextStyles.inputText,
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: AppTextStyles.inputLabel,
                hintText: 'Digite seu nome',
                hintStyle: AppTextStyles.inputHint,
                prefixIcon: const Icon(
                  Icons.person,
                  color: AppColors.primaryGreen,
                ),
                filled: true,
                fillColor: AppColors.inputFillColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                  borderSide: const BorderSide(
                    color: AppColors.primaryGreen,
                    width: AppDimensions.borderWidthThin,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                  borderSide: const BorderSide(
                    color: AppColors.primaryGreen,
                    width: AppDimensions.borderWidthMedium,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: AppDimensions.paddingLarge),
            
            // Usando botão com estilos padronizados
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: AppColors.textWhite,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: AppDimensions.paddingLarge,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                ),
                elevation: AppDimensions.elevationMedium,
              ),
              child: const Text(
                'BOTÃO EXEMPLO',
                style: AppTextStyles.button,
              ),
            ),
            
            const SizedBox(height: AppDimensions.paddingMedium),
            
            // Card com estilo padronizado
            Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                border: Border.all(
                  color: AppColors.borderGreen,
                  width: AppDimensions.borderWidthThin,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card de Exemplo',
                    style: AppTextStyles.titleSmall,
                  ),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  const Text(
                    'Conteúdo do card usando as constantes padronizadas.',
                    style: AppTextStyles.bodyText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
