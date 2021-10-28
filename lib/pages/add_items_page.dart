import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tarefa',
                ),
                controller: _textController,
                onFieldSubmitted: (value) {
                  Navigator.pop(context, value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha com um texto';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context, _textController.text);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
