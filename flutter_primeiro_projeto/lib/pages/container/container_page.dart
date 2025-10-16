import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {

  const ContainerPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Exemplo de Container'),),
           body: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            padding: EdgeInsets.all(40),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      offset: Offset(10, 10),
                    ),
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 10,
                      offset: Offset(-10, 10),
                    ),
                  ]
                ),
              ),
            ),
           ),
       );
  }
}