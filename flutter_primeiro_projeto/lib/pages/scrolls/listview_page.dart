import 'package:flutter/material.dart';

class ListviewPage extends StatelessWidget {

  const ListviewPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('List View Page'),),
           body: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(), //Icon(Icons.person),
                title: Text('Item $index'),
                subtitle: Text('Detalhes do item $index'),
                trailing: Icon(Icons.arrow_forward),
              );
            },
          ),
       );
  }
}