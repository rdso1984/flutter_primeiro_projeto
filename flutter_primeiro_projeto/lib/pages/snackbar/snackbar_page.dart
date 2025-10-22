import 'package:flutter/material.dart';

class SnackbarPage extends StatelessWidget {

  const SnackbarPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Snackbar Page'),),
           body: Column(
            children: [
              ElevatedButton(onPressed: (){
                final snackbar = SnackBar(
                  content: const Text('Usuario salvo com sucesso'),
                  backgroundColor: Colors.amber,
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      print('Clicado botão UNDO');
                    },
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }, child: Text('Simple SnackBar')),
              ElevatedButton(onPressed: (){}, child: Text('Simple SnackBar')),
            ],
           ),
       );
  }
}