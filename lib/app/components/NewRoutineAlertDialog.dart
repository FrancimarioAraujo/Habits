import 'package:click/app/providers/routinesProvider/RoutinesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewRoutineAlertDialog extends StatefulWidget {
  @override
  _NewRoutineAlertDialogState createState() => _NewRoutineAlertDialogState();
}

class _NewRoutineAlertDialogState extends State<NewRoutineAlertDialog> {
  final _formKey = GlobalKey<FormState>();

  late RoutinesProvider routinesProvider;
  final TextEditingController _nameRoutineTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorScheme themeColor = Theme.of(context).colorScheme;
    routinesProvider = Provider.of<RoutinesProvider>(context);
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
                controller: _nameRoutineTextController,
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await routinesProvider
                          .createRoutine(_nameRoutineTextController.text);
                      Navigator.pop(context);
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
