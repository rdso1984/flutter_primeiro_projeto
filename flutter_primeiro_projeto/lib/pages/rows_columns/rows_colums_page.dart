import 'package:flutter/material.dart';

class RowsColumsPage extends StatelessWidget {

  const RowsColumsPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            title: const Text('Rows & Columns'),
            backgroundColor: Colors.blue[300],),
           body: Container(
            width: 400,
            color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                    Text('Elemento 1'),
                    Text('Elemento 2'),
                    Text('Elemento 3'),
                    Container(
                      color: Colors.red,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Item 1'),
                          Text('Item 2'),
                          Text('Item 3'),
                        ],
                      ),
                    )
              ],
            ),
           ),
       );
  }
}