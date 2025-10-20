import 'package:flutter/material.dart';

class MediaQueryPage extends StatelessWidget {

  const MediaQueryPage({ super.key });

   @override
   Widget build(BuildContext context) {

      final mediaQuery = MediaQuery.of(context);

      final statusBarHeight = mediaQuery.padding.top;
      final heightApp = mediaQuery.size.height - statusBarHeight - kToolbarHeight;
      print(kToolbarHeight); // altura da AppBar
      print('Height App: $heightApp');
      print('Orientacao: ${mediaQuery.orientation}');
      print('Status Bar Height: $statusBarHeight');

      return Scaffold(
          appBar: AppBar(title: const Text('Media Query Page'),),
          body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue,
                width: mediaQuery.size.width * 0.50,
                height: heightApp * 0.5,
              ),
              Container(
                color: Colors.yellow,
                width: mediaQuery.size.width,
                height: heightApp * 0.5,
              ),
            ],
          ),
          ),
      );
  }
}