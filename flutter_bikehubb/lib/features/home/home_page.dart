import 'package:bikehubb/common/stat_card.dart';
import 'package:bikehubb/models/bike_ad.dart';
import 'package:bikehubb/services/bike_ad_service.dart';
import 'package:bikehubb/widgets/bike_ad_card.dart';
import 'package:flutter/material.dart';

enum PopupMenuPages {
  homepage,
  login,
  register,
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
    _fadeAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
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
           appBar: AppBar(
            backgroundColor: Color.fromRGBO(35, 39, 42, 1),
              title: AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return Text(
                          'BikeHubb',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.lerp(
                              Color.fromARGB(255, 24, 92, 62), // Cor mais escura
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
                                color: const Color.fromARGB(255, 27, 145, 63).withOpacity(0.5),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            toolbarHeight: 70,
            actions: [
              PopupMenuButton<PopupMenuPages>(
                icon: const Icon(Icons.menu,
                  color: Color(0xFF22c55e),
                ),
                tooltip: 'Selecione uma opção',
                onSelected: (PopupMenuPages valueSelected){
                  switch(valueSelected){
                    case PopupMenuPages.homepage:
                      Navigator.pushNamed(context, '/');
                      break;
                    case PopupMenuPages.login:
                      Navigator.pushNamed(context, '/login');
                      break;
                    case PopupMenuPages.register:
                      Navigator.pushNamed(context, '/register');
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<PopupMenuPages>>[
                    const PopupMenuItem<PopupMenuPages>(
                      value: PopupMenuPages.homepage,
                      child: Text('Página Inicial'),
                    ),
                    // const PopupMenuItem<PopupMenuPages>(
                    //   value: PopupMenuPages.login,
                    //   child: Text('Login'),
                    // ),
                    // const PopupMenuItem<PopupMenuPages>(
                    //   value: PopupMenuPages.register,
                    //   child: Text('Registrar'),
                    // ),
                  ];
                },
              ),
            ],
           ),

           body: SingleChildScrollView(
             child: Column(
               children: [
                 Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1c222e),
                        Color(0xFF179447),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Icon(
                            Icons.pedal_bike,
                            color: Colors.white,
                            size: 100,
                          ),
                        AnimatedBuilder(
                          animation: _fadeAnimation,
                          builder: (context, child) {
                            return Text(
                              'Encontre a bike dos seus sonhos',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.lerp(
                                  Color.fromARGB(255, 24, 92, 62), // Cor mais escura
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
                                    color: const Color.fromARGB(255, 27, 145, 63).withOpacity(0.5),
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
                            fontWeight: FontWeight.w700
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
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: ElevatedButton(
                            onPressed: (){
                              // Navigator.pushNamed(context, '/search');
                              Navigator.pushNamed(context, '/');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1c222e),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: ElevatedButton(
                            onPressed: (){
                              // Navigator.pushNamed(context, '/advertise');
                              Navigator.pushNamed(context, '/');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1c222e),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                        SizedBox(height: 40),
                        StatCard(
                          icon: Icons.check_circle,
                          value: '10K+',
                          label: 'Bicicletas Negociadas',
                        ),
                        SizedBox(height: 30),
                        StatCard(
                          icon: Icons.people,
                          value: '5K+',
                          label: 'Usuários Ativos',
                        ),
                        SizedBox(height: 30),
                        StatCard(
                          icon: Icons.location_city,
                          value: '50+',
                          label: 'Cidades',
                        ),
                        SizedBox(height: 30),
                        StatCard(
                          icon: Icons.thumb_up,
                          value: '99%',
                          label: 'Satisfação',
                        ),
                        SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                 ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1c222e),
                  ),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          AnimatedBuilder(
                          animation: _fadeAnimation,
                          builder: (context, child) {
                            return Text(
                              'Bicicletas em Destaque',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.lerp(
                                  Color.fromARGB(255, 24, 92, 62), // Cor mais escura
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
                                    color: const Color.fromARGB(255, 27, 145, 63).withOpacity(0.5),
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
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 30),
                        // Grid de anúncios vindos do banco de dados
                        FutureBuilder<List<BikeAd>>(
                          future: _bikeAdService.getFeaturedBikes(limit: 4),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
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

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: bikes.length,
                              itemBuilder: (context, index) {
                                return BikeAdCard(
                                  bikeAd: bikes[index],
                                  onTap: () {
                                    // Navegação para detalhes do anúncio
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   '/bike-details',
                                    //   arguments: bikes[index],
                                    // );
                                    print('Clicou no anúncio: ${bikes[index].title}');
                                  },
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ),
               ],
             ),
           ),
       );
  }
}