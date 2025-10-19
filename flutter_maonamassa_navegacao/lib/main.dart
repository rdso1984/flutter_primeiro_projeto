import 'package:flutter/material.dart';
import 'package:flutter_maonamassa_navegacao/core/navigator_observer_custom.dart';
import 'package:flutter_maonamassa_navegacao/pages/detalhe_page.dart';
import 'package:flutter_maonamassa_navegacao/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      navigatorObservers: [
        NavigatorObserverCustom(), //Adiciona o observer personalizado, que observa as mudanças de navegação
      ],
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            settings: settings, // Passa as configurações da rota
            builder: (context) => const HomePage());
        } else if (settings.name == '/detalhe') {
          String parametro = settings.arguments as String ?? 'Sem parâmetro';
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => DetalhePage(parametro: parametro));
        }
        return null; // Retorna null se a rota não for reconhecida
      },
      // routes: {
      //   '/': (context) => const HomePage(),
      //   '/detalhe': (context) => const DetalhePage(),
      // },
    );
  }
}
