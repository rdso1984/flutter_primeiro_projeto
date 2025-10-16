import 'package:flutter/material.dart';

enum PopupMenuPages {
  container,
  rows_columns,
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
                    )
                  ];
                },
              ),
            ],
          ),
           body: Container(),
       );
  }
}