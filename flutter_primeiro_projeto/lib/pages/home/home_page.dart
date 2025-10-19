import 'package:flutter/material.dart';

enum PopupMenuPages {
  container,
  rows_columns,
  layout_builder,
  botoes_rotacao_texto,
}

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            title: const Text('Home Page'),
            backgroundColor: Colors.blue[300],
            actions: [
              PopupMenuButton<PopupMenuPages>(
                // icon: Icon(Icons.restaurant_menu),
                tooltip: 'Selecione um item do menu',
                onSelected: (PopupMenuPages valueSelected){
                  switch(valueSelected){
                    case PopupMenuPages.container:
                      Navigator.of(context).pushNamed('/container');
                      break;
                    case PopupMenuPages.rows_columns:
                      Navigator.of(context).pushNamed('/rows_columns');
                      break;
                    case PopupMenuPages.layout_builder:
                      Navigator.of(context).pushNamed('/layout_builder');
                      break;
                    case PopupMenuPages.botoes_rotacao_texto:
                      Navigator.of(context).pushNamed('/botoes_rotacao_texto');
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuItem<PopupMenuPages>>[
                    PopupMenuItem<PopupMenuPages> (
                      value: PopupMenuPages.container,
                      child: Text('Container'),
                    ),
                    PopupMenuItem<PopupMenuPages> (
                      value: PopupMenuPages.rows_columns,
                      child: Text('Rows & Columns'),
                    ),
                    PopupMenuItem<PopupMenuPages> (
                      value: PopupMenuPages.layout_builder,
                      child: Text('Layout Builder'),
                    ),
                    PopupMenuItem<PopupMenuPages> (
                      value: PopupMenuPages.botoes_rotacao_texto,
                      child: Text('Botoes Rotacao Texto'),
                    ),
                  ];
                },
              ),
            ],
          ),
           body: Container(),
       );
  }
}