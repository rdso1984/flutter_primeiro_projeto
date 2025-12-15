import 'package:bikehubb/common/app_constants.dart';
import 'package:bikehubb/features/shared/app_footer.dart';
import 'package:bikehubb/features/shared/bikehubb_appbar.dart';
import 'package:bikehubb/features/shared/bikehubb_drawer.dart';
import 'package:bikehubb/common/stat_card.dart';
import 'package:bikehubb/models/bike_ad.dart';
import 'package:bikehubb/services/bike_ad_service.dart';
import 'package:bikehubb/widgets/bike_ad_card.dart';
import 'package:flutter/material.dart';

enum PopupMenuPages {
  homepage,
  login,
  // register,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final BikeAdService _bikeAdService = BikeAdService();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
    return Scaffold(
      appBar: BikeHubbAppBar(fadeAnimation: _fadeAnimation, showDrawer: true),
      drawer: const BikeHubbDrawer(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1c222e), Color(0xFF179447)],
                ),
              ),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/bikehubb_logo.png',
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(height: 30),
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Text(
                            'Encontre a bike dos seus sonhos',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.lerp(
                                Color.fromARGB(
                                  255,
                                  24,
                                  92,
                                  62,
                                ), // Cor mais escura
                                Color(0xFF22c55e), // Cor original
                                _fadeAnimation.value,
                              ),
                              fontFamily: 'Segoe UI, Roboto',
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 20,
                                  color: const Color.fromARGB(
                                    255,
                                    27,
                                    145,
                                    63,
                                  ).withOpacity(0.5),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'A maior plataforma de compra e venda de bicicletas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Segoe UI, Roboto',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Bicicletas novas, usadas e acessórios com segurança e facilidade',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Segoe UI, Roboto',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/search');
                            Navigator.pushNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1c222e),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: Color(0xFF22c55e),
                                width: 1,
                              ),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'Buscar Bicicletas',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/advertise');
                            Navigator.pushNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1c222e),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: Color(0xFF22c55e),
                                width: 1,
                              ),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'Anunciar Grátis',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Seção de estatísticas
            Container(
              color: Color(0xFF179447),
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [Color(0xFF1c222e), Color(0xFF179447)],
              //   ),
              // ),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Divider(color: Colors.white24, thickness: 1),
                      SizedBox(height: 20),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: PageView(
                          padEnds: false,
                          controller: PageController(viewportFraction: 0.65),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: StatCard(
                                icon: Icons.check_circle,
                                value: '10K+',
                                label: 'Bicicletas Negociadas',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: StatCard(
                                icon: Icons.people,
                                value: '5K+',
                                label: 'Usuários Ativos',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: StatCard(
                                icon: Icons.location_city,
                                value: '50+',
                                label: 'Cidades',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: StatCard(
                                icon: Icons.thumb_up,
                                value: '99%',
                                label: 'Satisfação',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white24, thickness: 1),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),

            //Grid bicicletas em destaque
            Container(
              decoration: BoxDecoration(color: Color(0xFF1c222e)),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Text(
                            'Bicicletas em Destaque',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.lerp(
                                Color.fromARGB(
                                  255,
                                  24,
                                  92,
                                  62,
                                ), // Cor mais escura
                                Color(0xFF22c55e), // Cor original
                                _fadeAnimation.value,
                              ),
                              fontFamily: 'Segoe UI, Roboto',
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 20,
                                  color: const Color.fromARGB(
                                    255,
                                    27,
                                    145,
                                    63,
                                  ).withOpacity(0.5),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Confira as melhores ofertas da semana selecionadas especialmente para você',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Segoe UI, Roboto',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 30),
                      Divider(color: Colors.white24, thickness: 1),
                      SizedBox(height: 20),

                      // Grid de anúncios vindos do banco de dados
                      FutureBuilder<List<BikeAd>>(
                        future: _bikeAdService.getFeaturedBikes(limit: 3),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(40),
                                child: CircularProgressIndicator(
                                  color: Color(0xFF22c55e),
                                ),
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 60,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Erro ao carregar anúncios',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(40),
                                child: Text(
                                  'Nenhum anúncio disponível',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          }

                          final bikes = snapshot.data!;

                          return SizedBox(
                            height: 340,
                            child: PageView.builder(
                              padEnds: false,
                              controller: PageController(
                                viewportFraction: 0.92,
                              ),
                              itemCount: bikes.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: BikeAdCard(
                                    bikeAd: bikes[index],
                                    onTap: () {
                                      // Navegação para detalhes do anúncio
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   '/bike-details',
                                      //   arguments: bikes[index],
                                      // );
                                      print(
                                        'Clicou no anúncio: ${bikes[index].title}',
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.white24, thickness: 1),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/advertise');
                            Navigator.pushNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF179447),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: Color(0xFF22c55e),
                                width: 1,
                              ),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'Ver todos os Anúncios',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),

            //Passos para anunciar
            Container(
              decoration: BoxDecoration(color: Color.fromARGB(255, 36, 46, 65)),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Text(
                            'Como Funciona',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.lerp(
                                Color.fromARGB(
                                  255,
                                  24,
                                  92,
                                  62,
                                ), // Cor mais escura
                                Color(0xFF22c55e), // Cor original
                                _fadeAnimation.value,
                              ),
                              fontFamily: 'Segoe UI, Roboto',
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 20,
                                  color: const Color.fromARGB(
                                    255,
                                    27,
                                    145,
                                    63,
                                  ).withOpacity(0.5),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Simples, Rápido e Seguro',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Segoe UI, Roboto',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.white24, thickness: 1),
                      AspectRatio(
                        aspectRatio: 1.4,
                        child: PageView(
                          padEnds: false,
                          controller: PageController(viewportFraction: 0.75),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: StatCard(
                                icon: Icons.check_circle,
                                value: '1. Cadastre-se',
                                label: 'Crie sua conta gratuitamente',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: StatCard(
                                icon: Icons.people,
                                value: '2. Encontre sua Bike',
                                label:
                                    'Use nossos filtros avançados para encontrar a bicicleta perfeita para você',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: StatCard(
                                icon: Icons.location_city,
                                value: '3. Entre em Contato',
                                label:
                                    'Converse com o vendedor de forma segura e negocie diretamente',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white24, thickness: 1),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),

            //Texto final
            Container(
              decoration: BoxDecoration(color: Color(0xFF169946)),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Text(
                        'Pronto para encontrar sua próxima bike?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Segoe UI, Roboto',
                          color: Color(0xFF212b25),
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Junte-se a Milhares de Ciclistas que Já Encontraram a Bicicleta Ideal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Segoe UI, Roboto',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/search');
                            Navigator.pushNamed(context, '/');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1c222e),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(
                                color: Color(0xFF22c55e),
                                width: 1,
                              ),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'Começar Agora\nÉ Grátis!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),

            // Rodapé
            AppFooter(),
          ],
        ),
      ),
    );
  }
}
