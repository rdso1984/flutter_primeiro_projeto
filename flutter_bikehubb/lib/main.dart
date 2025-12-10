import 'package:bikehubb/features/dashboard/dashboard_page.dart';
import 'package:bikehubb/features/home/home_page.dart';
import 'package:bikehubb/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Supabase
  await Supabase.initialize(
    url: 'https://krlhnihkslmmihprkwqm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtybGhuaWhrc2xtbWlocHJrd3FtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk5NTkxMDUsImV4cCI6MjA2NTUzNTEwNX0.oD7ZOVTyvGy58u2HCSfoKwFcVxjhe0UUEAvcfSa7cp0',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BikeHubb',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
