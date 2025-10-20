import 'package:flutter/material.dart';
import 'package:flutter_primeiro_projeto/pages/dialogs/dialog_custom.dart';

class DialogsPage extends StatelessWidget {

  const DialogsPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Dialogs Page'),),
           body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  showDialog(
                    barrierDismissible: false, //Se usuario nao clicar no botao, nao fecha
                    context: context, 
                    builder: (context) {
                      return DialogCustom();
                    }
                  );
                }, child: Text('Dialog')),
                ElevatedButton(onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context) => SimpleDialog(
                      title: const Text('Simple Dialog Title'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () => Navigator.of(context).pop(), 
                          child: const Text('Option 1')
                        ),
                        SimpleDialogOption(
                          onPressed: () => Navigator.of(context).pop(), 
                          child: const Text('Option 2')
                        ),
                      ],
                    )
                  );
                }, child: Text('Simple Dialog')),
                ElevatedButton(onPressed: (){
                  showDialog(
                    barrierDismissible: false, //Se usuario nao clicar no botao, nao fecha
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: const Text('Dialog Title'),
                      content: const Text('This is a simple dialog content.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(), 
                          child: const Text('Close')
                        ),
                      ],
                    )
                  );
                }, child: Text('Alert Dialog')),
                ElevatedButton(onPressed: (){}, child: Text('Time Dialog')),
                ElevatedButton(onPressed: (){}, child: Text('Date Picker')),
              ],
            ),
           ),
       );
  }
}