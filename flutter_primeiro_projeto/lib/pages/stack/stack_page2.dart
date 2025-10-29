import 'package:flutter/material.dart';

class StackPage2 extends StatelessWidget {

  const StackPage2({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Stack2'),),
           body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bW91bnRhaW58ZW58MHx8MHx8fDA%3D&w=1000&q=80'),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              Container(
                color: Colors.white38, // camada semi-transparente
              ),
              Positioned(
                bottom: 40,
                left: 10,
                right: 10,
                child: Card(
                  color: Colors.white.withOpacity(0.8),
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(  
                          'Esta é uma página de exemplo utilizando Stack com uma imagem de fundo',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Text('New York, USA', 
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.blue[900]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
           ),
       );
  }
}