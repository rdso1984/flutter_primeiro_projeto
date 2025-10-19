import 'package:flutter/material.dart';

class DetalhePage extends StatelessWidget {

  final String parametro;

  DetalhePage({ super.key, required this.parametro });

  @override
  Widget build(BuildContext context) {
  // var parametro = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),),
        body: Center(
          child: Text(parametro),
        ),
    );
  }
}