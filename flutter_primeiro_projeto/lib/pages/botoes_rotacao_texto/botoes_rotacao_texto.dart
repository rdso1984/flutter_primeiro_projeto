import 'package:flutter/material.dart';

class BotoesRotacaoTexto extends StatelessWidget {

  const BotoesRotacaoTexto({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Botoes Rotacao Texto'),),
           body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Text('Rafael Oliveira'),
                ),
                TextButton(
                  onPressed: (){},
                  child: Text('Salvar'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.all(10),
                    minimumSize: Size(50, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.exit_to_app),),
                ElevatedButton(
                  onPressed: (){}, 
                  child: Text('Salvar'),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.red,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(10),
                    minimumSize: Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: (){}, 
                  icon: Icon(Icons.air),
                  label: Text('Modo Avião'),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.red,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(10),
                    minimumSize: Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: (){}, 
                  child: Text('Salvar'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if(states.contains(MaterialState.pressed)){
                        return Colors.greenAccent;
                      }
                      else if(states.contains(MaterialState.hovered)){
                        return Colors.green.shade700;
                      }
                      return Colors.green;
                    },),
                    minimumSize: WidgetStateProperty.resolveWith((states) {
                      if(states.contains(MaterialState.pressed)){
                        return Size(150, 150);
                      }
                      else if(states.contains(MaterialState.hovered)){
                        return Size(180, 180);
                      }
                      return Size(120, 50);
                    },),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: (){},
                  child: Text('Clique aqui'),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () => print('Gesture Detector'),
                  child: Text('gesture detector'),
                ),
              ],
            ),
           ),
       );
  }
}