import 'package:flutter/material.dart';

class LayoutBuilderPage extends StatelessWidget {

  const LayoutBuilderPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Layout Builder Page'),),
           body: Center(
               child: LayoutBuilder(
                   builder: (context, constraints) {
                      //  if (constraints.maxWidth < 600) {
                      //      return const Text('This is a small screen');
                      //  } else {
                      //      return const Text('This is a large screen');
                      //  }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.blue,
                            width: constraints.maxWidth * 0.5,
                            height: constraints.maxHeight * 0.5,
                          ),
                          Container(
                            color: Colors.red,
                            width: constraints.maxWidth * 0.5,
                            height: constraints.maxHeight * 0.5,
                          ),
                        ],
                      );
                   },
               ),
           ),
       );
  }
}