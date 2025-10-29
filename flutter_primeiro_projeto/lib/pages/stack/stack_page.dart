import 'package:flutter/material.dart';

class StackPage extends StatelessWidget {

  const StackPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Stack'),),
           body: Stack(
            children: [
              Container(
                // width: 200,
                // height: 200,
                color: Colors.blue,
              ),
              Positioned(
                top: 40,
                right: 80,
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.red,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
              ),
            ],
           ),
       );
  }
}