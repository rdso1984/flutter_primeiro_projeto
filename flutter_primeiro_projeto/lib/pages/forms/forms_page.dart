import 'package:flutter/material.dart';

class FormsPage extends StatefulWidget {

  const FormsPage({ super.key });

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {

  final formKey = GlobalKey<FormState>();
  final senhaEC = TextEditingController();

  @override
  void dispose() {
    senhaEC.dispose();
    super.dispose();
  }

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
                    controller: senhaEC,
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if(value == null || value.isEmpty){
                        return 'Senha obrigatória';
                      }
                      if(value.length < 6){
                        return 'Senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      var formValid = formKey.currentState?.validate() ?? false;
                      var message = 'Formulário inválido! Dado inválido ${senhaEC.text}';

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