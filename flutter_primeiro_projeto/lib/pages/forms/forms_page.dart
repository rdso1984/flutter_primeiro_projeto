import 'package:flutter/material.dart';

class FormsPage extends StatefulWidget {

  const FormsPage({ super.key });

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {

  final formKey = GlobalKey<FormState>();

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Forms Page'),),
           body: Form(
             key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-mail'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      var formValid = formKey.currentState?.validate() ?? false;
                      var message = 'Formulário inválido!';

                      if(formValid){
                        message = 'Formulário válido!';
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                      );
                    },
                    child: Text('SALVAR'),
                  ),
                ],
              ),
            ),
         ),
       );
  }
}