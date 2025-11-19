import 'package:flutter/material.dart';

class BottomNavigationBarPage extends StatefulWidget {

  const BottomNavigationBarPage({ super.key });

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
   
   int indice = 0;
   
   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Bottom Navigation Bar Page'),),
           bottomNavigationBar: BottomNavigationBar(
            currentIndex: indice,
            onTap: (index) { // Atualiza o índice selecionado ao clicar nos itens
              setState(() {
                indice = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.search),
              //   label: 'Search',
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.person),
              //   label: 'Profile',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings), 
                label: 'Page1',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.iso_outlined), 
                label: 'Page2',
              ),
            ],
           ),
           body: IndexedStack(
            index: 0,
            children: const [
              Center(child: Text('Home Page')),
              Center(child: Text('Search Page')),
              Center(child: Text('Profile Page')),
              Center(child: Text('Page 1 Content')),
              Center(child: Text('Page 2 Content')),
            ],
           ),
       );
  }
}