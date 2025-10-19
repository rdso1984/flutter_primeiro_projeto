import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/detalhe', arguments: 'Olá da Home Page!');
              }, child: Text('Ir para Detalhes'),),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/detalhe', arguments: 'DETALHES 2');
              }, child: Text('Ir para Detalhes 2'),),
          ],
        ),
      ),
    );
  }
}