import 'package:bikehubb/common/app_constants.dart';
import 'package:flutter/material.dart';

class DrawerBikehubb extends StatefulWidget {

  const DrawerBikehubb({ super.key });

  @override
  State<DrawerBikehubb> createState() => _DrawerBikehubbState();
}

class _DrawerBikehubbState extends State<DrawerBikehubb> {

   @override
   Widget build(BuildContext context) {
       return Drawer(
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
                    'assets/images/bikehubb_logo.png',
                    width: 80,
                    height: 80,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'BikeHubb',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: AppColors.primaryGreen),
              title: Text('Início', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: Icon(Icons.login, color: AppColors.primaryGreen),
              title: Text('Login', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      );
  }
}