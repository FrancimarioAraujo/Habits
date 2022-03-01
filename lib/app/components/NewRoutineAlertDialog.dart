import 'package:flutter/material.dart';

class NewRoutineAlertDialog extends StatefulWidget {
  @override
  _NewRoutineAlertDialogState createState() => _NewRoutineAlertDialogState();
}

class _NewRoutineAlertDialogState extends State<NewRoutineAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Adicionar novo hábito"),
      content: Form(
        key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor digite o nome do hábito";
                  }
                  return null;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text("Criar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
